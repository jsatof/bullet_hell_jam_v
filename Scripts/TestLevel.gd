extends Node2D

var Enemy = preload("res://Scenes/Enemy.tscn")

var current_group := 0
var groups = []

func _ready():
	# Rage at the lack of a struct feature in this god forsaken language
	groups.append({
		"time": 2.0, "enemies": []
	})
	groups.append({
		"time": 12.0, "enemies": [
			{"health":100,"position":Vector2(0.0, -500.0),
				"movement": [
				{ point=Vector2(-330.0, -370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
				{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
				{ type="radial",cycles=20,shot_delay=0.05,init_delay=0.5,rotation=20,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,target=false,color=Color("PURPLE")
				}},
				{ type="radial",cycles=20,shot_delay=0.05,init_delay=0.5,rotation=2.5,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,target=false,color=Color("CYAN")
				}},
				{ type="radial",cycles=10,shot_delay=0.1,init_delay=0.5,rotation=2.5,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,target=true,color=Color("RED")
				}}
				]
			},
			{"health":100,"position":Vector2(0.0, -500.0),
				"movement": [
				{ point=Vector2(330.0, 370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=4.0 },
				{ point=Vector2(440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
				{ type="linear",cycles=20,shot_delay=0.3,init_delay=0.5,rotation=20,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,target=true,color=Color("YELLOW")
				}}
				]
			},
			{"health":100,"position":Vector2(0.0, -500.0),
				"movement": [
				{ point=Vector2(0.0, -370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
				{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
				{ type="linear",cycles=20,shot_delay=0.3,init_delay=0.5,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,target=false,color=Color("YELLOW")
				}}
				]
			},
		]
	})
	# Some crazy shit here man
	groups.append({
		"time": 10.0, "enemies": [
			{"health":100,"position":Vector2(0.0, -500.0),
				"movement": [
				{ point=Vector2(-330.0, -370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
				{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
				{ type="radial",cycles=10,shot_delay=0.1,init_delay=0.5,rotation=20,rotate_speed=1,
					spawn_params={"amount":15},
					bullet_data={
					velocity=400.0,target=false,color=Color("PURPLE"),movement="sin",amplitude=3,frequency=5
				}},
				]
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
