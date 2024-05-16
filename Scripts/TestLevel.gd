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
		"time": 5.0, "enemies": [
			{"health":100,"speed":50,"position":Vector2(0.0, -400.0),"lifetime":20,
				"movement": [
				{ point=Vector2(-330.0, -370.0),time=1,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=1.0 },
				{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
					{ type="radial",cycles=5,shot_delay=0.3,
						spawn_params={"amount":20},
						bullet_data={
						velocity=400.0,target=false,color=Color("PURPLE")
					}}
				],
			},
		]
	})
	call_groups_seqenced()

func call_groups_seqenced():
	for i in range(current_group, groups.size()):
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
		for spawner in i["spawners"]:
			e.spawners.append(spawner)
		add_child(e)
