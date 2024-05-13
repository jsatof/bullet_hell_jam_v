extends Node2D

var Enemy = preload("res://Scenes/Enemy.tscn")

var current_group: int = -1
var groups = []

func _ready():
	current_group = 0
	# Rage at the lack of a struct feature in this god forsaken language
	groups.append({
		"time": 2.0, "enemies": []
	})
	groups.append({
		"time": 10.0, "enemies": [
			{"health": 100, "speed": 300, "position": Vector2(0.0, -400.0), "lifetime": 20,
			"movement": [Vector2(0.0, 0.0)]},
			{"health": 100, "speed": 300, "position": Vector2(100.0, -430.0), "lifetime": 20,
			"movement": [Vector2(200.0, 0.0)]},
			{"health": 100, "speed": 300, "position": Vector2(-80.0, -470.0),  "lifetime": 20,
			"movement": [Vector2(-140.0, 0.0)]},
		]
	})
	groups.append({
		"delay": 0.0, "time": 10.0, "enemies": [
			{"health": 100, "speed": 400, "position": Vector2(0.0, -400.0), "lifetime": 20,
			"movement": [Vector2(0.0, 0.0)]},
			{"health": 100, "speed": 400, "position": Vector2(300.0, -470.0), "lifetime": 20,
			"movement": [Vector2(0.0, 0.0)]},
			{"health": 100, "speed": 400, "position": Vector2(-300.0, -500.0),  "lifetime": 20,
			"movement": [Vector2(0.0, 0.0)]},
		]
	})
	call_groups_seqenced()

func call_groups_seqenced():
	for i in range(current_group, groups.size()):
		print(current_group)
		spawn_group()
		await wait_group_time()
		current_group += 1

func wait_group_time():
	await get_tree().create_timer(groups[current_group]["time"]).timeout
	print("Finished group")

func spawn_group():
	for i in groups[current_group]["enemies"]:
		var e = Enemy.instantiate()
		e.health = i["health"]
		e.velocity = i["speed"]
		e.lifetime = i["lifetime"]
		e.position = i["position"]
		for pos in i["movement"]:
			e.movement_targets.append(pos)

		add_child(e)
