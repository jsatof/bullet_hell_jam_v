extends Node2D

const LEVEL = preload("res://Scripts/Level.gd")

var level
var current_group := 0
var groups = []

func _ready():
	level = LEVEL.new()
	self.add_child(level)
	# Rage at the lack of a struct feature in this god forsaken language
	level.groups.append({
		"time": 10.0, "enemies": [
			{"type":"plate","health":100,"position":Vector2(0.0, -500.0),
				"movement": [
					{ point=Vector2(-200.0, -370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
					{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
					{ type="radial",cycles=20,shot_delay=0.3,init_delay=0.5,random=Vector2(-10,10),
					spawn_params={"amount":10},
					bullet_data={
					velocity=20.0,acceleration=1.05,color=Color("YELLOW")
					}}
				]
			},
			{"type":"drone","health":100,"position":Vector2(0.0, -500.0),
				"movement": [
					{ point=Vector2(200.0, -370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
					{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
					{ type="radial",cycles=10,shot_delay=2,init_delay=0.5,rotation=0,target=true,
					spawn_params={"amount":5,"degrees":25},
					bullet_data={
					velocity=200.0,color=Color("RED"),size=3,
					}},
					{ type="radial",cycles=10,shot_delay=0.5,init_delay=0.75,rotation=0,target=true,random=Vector2(-3,3),
					spawn_params={"amount":3,"degrees":25},
					bullet_data={
					velocity=200.0,color=Color("PURPLE")
					}},
				]
			},
		]
	})
	level.groups.append({
		"time": 12.0, "enemies": [
			{"type":"plate","health":100,"position":Vector2(0.0, -500.0),
				"movement": [
				{ point=Vector2(-330.0, -370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
				{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
				{ type="radial",cycles=20,shot_delay=0.05,init_delay=0.5,rotation=20,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,color=Color("PURPLE")
				}},
				{ type="radial",cycles=20,shot_delay=0.05,init_delay=0.5,rotation=2.5,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,color=Color("CYAN")
				}},
				{ type="radial",cycles=10,shot_delay=0.1,init_delay=0.5,rotation=2.5,target=true,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,color=Color("RED")
				}}
				]
			},
			{"type":"plate","health":100,"position":Vector2(0.0, -500.0),
				"movement": [
				{ point=Vector2(330.0, 370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=4.0 },
				{ point=Vector2(440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
				{ type="linear",cycles=20,shot_delay=0.3,init_delay=0.5,rotation=20,target=true,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,color=Color("YELLOW")
				}}
				]
			},
			{"type":"plate","health":100,"position":Vector2(0.0, -500.0),
				"movement": [
				{ point=Vector2(0.0, -370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
				{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
				{ type="linear",cycles=20,shot_delay=0.3,init_delay=0.5,
					spawn_params={"amount":10},
					bullet_data={
					velocity=400.0,color=Color("YELLOW")
				}}
				]
			},
		]
	})
	# Some crazy shit here man
	level.groups.append({
		"time": 10.0, "enemies": [
			{"type":"dragonfly","health":100,"position":Vector2(0.0, -500.0),
				"movement": [
				{ point=Vector2(-330.0, -370.0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
				{ point=Vector2(-440.0, 500.0),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
				{ type="radial",cycles=10,shot_delay=0.1,init_delay=0.5,rotation=20,angular_rate=1,
					spawn_params={"amount":15},
					bullet_data={
					velocity=400.0,color=Color("PURPLE"),movement="sin",amplitude=3,frequency=5
				}},
				]
			},
		]
	})

	level.start_level()
