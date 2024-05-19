extends Node2D

@onready var audio_manager := get_node("/root/AudioManager")
@onready var soundtrack := AudioStreamOggVorbis.load_from_file("res://Resources/Audio/Music/Tsumi.ogg")

const LEVEL = preload("res://Scripts/Level.gd")
@onready var globals := $'/root/GlobalState'

var level
var current_group := 0
var groups = []

const bottom := 288.0/2.0 + 32
const top := -bottom
const right := 384.0/4.0 + 32
const left := -right

func _ready() -> void:
	audio_manager.set_soundtrack(soundtrack)
	audio_manager.play_soundtrack()

	globals.start_level()
	level = LEVEL.new()
	self.add_to_group("level")
	self.add_child(level)
	level.groups.append({
		"time": 10.0, "enemies": [
			{"type":"plate","health":100,"position":Vector2(0.0, top),
				"movement": [
					{ point=Vector2(left+64, top+64),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
					{ point=Vector2(left, bottom),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
					{ type="radial",cycles=20,shot_delay=0.3,init_delay=0.5,random=Vector2(-10,10),
					spawn_params={"amount":10},
					bullet_data={
					velocity=20.0,acceleration=1.05,color=Color("YELLOW")
					}}
				]
			},
			{"type":"plate","health":100,"position":Vector2(0.0, top),
				"movement": [
					{ point=Vector2(left+80, top+64),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
					{ point=Vector2(left, bottom),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
					{ type="radial",cycles=20,shot_delay=0.3,init_delay=0.5,random=Vector2(-10,10),
					spawn_params={"amount":10},
					bullet_data={
					velocity=20.0,acceleration=1.05,color=Color("YELLOW")
					}}
				]
			},
			{"type":"drone","health":100,"position":Vector2(0.0, top),
				"movement": [
					{ point=Vector2(right-64, top+70),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
					{ point=Vector2(right, bottom),time=3,trans=Tween.TRANS_QUINT,ease=Tween.EASE_IN,pause=0.0 }
				],
				"spawners": [
					{ type="radial",cycles=10,shot_delay=2,init_delay=0.5,rotation=0,target=true,
					spawn_params={"amount":5,"degrees":25},
					bullet_data={
					velocity=100.0,color=Color("RED"),size=2,
					}},
					{ type="radial",cycles=10,shot_delay=0.5,init_delay=0.75,rotation=0,target=true,random=Vector2(-3,3),
					spawn_params={"amount":3,"degrees":25},
					bullet_data={
					velocity=100.0,color=Color("PURPLE")
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
