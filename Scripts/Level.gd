extends Node2D

var EnemyPlate = preload("res://Scenes/EnemyPlate.tscn")
var EnemyDrone = preload("res://Scenes/EnemyDrone.tscn")
var EnemyDragonfly = preload("res://Scenes/EnemyDragonfly.tscn")

var current_group := 0
var groups = []

func start_level(start_group := 0) -> void:
	current_group = start_group
	call_groups_seqenced()

func call_groups_seqenced() -> void:
	for i in range(current_group, groups.size()):
		spawn_group()
		await wait_group_time()
		current_group += 1

func wait_group_time() -> void:
	await get_tree().create_timer(groups[current_group]["time"]).timeout

func spawn_group() -> void:
	for i in groups[current_group]["enemies"]:
		var e
		match i["type"]:
			"plate":
				e = EnemyPlate.instantiate()
			"drone":
				e = EnemyDrone.instantiate()
			"dragonfly":
				e = EnemyDragonfly.instantiate()
			_:
				e = EnemyPlate.instantiate()
		e.max_health = i["health"]
		e.position = i["position"]
		for pos in i["movement"]:
			e.movement_targets.append(pos)
		for spawner in i["spawners"]:
			e.spawners.append(spawner)
		add_child(e)
