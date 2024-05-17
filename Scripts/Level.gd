extends Node2D

var Enemy = preload("res://Scenes/Enemy.tscn")

var current_group := 0
var groups = []

func start_level():
	call_groups_seqenced()

func call_groups_seqenced():
	for i in range(current_group, groups.size()):
		spawn_group()
		await wait_group_time()
		current_group += 1

func wait_group_time():
	await get_tree().create_timer(groups[current_group]["time"]).timeout

func spawn_group():
	for i in groups[current_group]["enemies"]:
		var e = Enemy.instantiate()
		e.max_health = i["health"]
		e.position = i["position"]
		for pos in i["movement"]:
			e.movement_targets.append(pos)
		for spawner in i["spawners"]:
			e.spawners.append(spawner)
		add_child(e)
