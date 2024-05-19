extends Node2D

@onready var audio_manager := get_node("/root/AudioManager")
@onready var soundtrack := AudioStreamOggVorbis.load_from_file("res://Resources/Audio/Music/Tsumi.ogg")

const LEVEL = preload("res://Scripts/Level.gd")
@onready var globals := $'/root/GlobalState'

var level
var groups = []

const HEIGHT := 288
const WIDTH := 384

const BOTTOM := HEIGHT/2 + 64
const TOP := -BOTTOM
const RIGHT := WIDTH/4 + 64
const LEFT := -RIGHT

const COL := WIDTH/(2*6)
const COL5 := -WIDTH/4 + 6 * COL - COL/2
const COL0 := -WIDTH/4 + 1 * COL - COL/2
const COL1 := -WIDTH/4 + 2 * COL - COL/2
const COL2 := -WIDTH/4 + 3 * COL - COL/2
const COL3 := -WIDTH/4 + 4 * COL - COL/2
const COL4 := -WIDTH/4 + 5 * COL - COL/2

const ROW := HEIGHT/9
const ROW0 := -HEIGHT/2 + 1 * ROW - ROW/2
const ROW1 := -HEIGHT/2 + 2 * ROW - ROW/2
const ROW2 := -HEIGHT/2 + 3 * ROW - ROW/2
const ROW3 := -HEIGHT/2 + 4 * ROW - ROW/2
const ROW4 := -HEIGHT/2 + 5 * ROW - ROW/2
const ROW5 := -HEIGHT/2 + 6 * ROW - ROW/2
const ROW6 := -HEIGHT/2 + 7 * ROW - ROW/2
const ROW7 := -HEIGHT/2 + 8 * ROW - ROW/2
const ROW8 := -HEIGHT/2 + 9 * ROW - ROW/2

func _ready() -> void:
	audio_manager.set_soundtrack(soundtrack)
	audio_manager.play_soundtrack()

	globals.start_level()
	level = LEVEL.new()
	self.add_to_group("level")
	self.add_child(level)

	print(Vector2(COL1, ROW2))

	level.groups.append({
		"time":3, "enemies":[]
	})
	level.groups.append({
		"time": 2.0, "enemies": [
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL1, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=0.5,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL2, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=1.0,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=1.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=1.5,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL4, TOP),time=1.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=2.0,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 1.0, "enemies": [
			{"type":"plate","health":50,"position":Vector2(COL3, TOP),
				"movement": [
					{ point=Vector2(COL3, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=10,shot_delay=2.0,init_delay=0.5,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL2, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=1.0,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 5.0, "enemies": [
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL1, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=0.5,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL2, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=1.0,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=1.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=1.5,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL4, TOP),time=1.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW8),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=1,shot_delay=2.0,init_delay=2.0,target=false,
					spawn_params={"amount":3,"degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})

	level.groups.append({
		"time": 11.0, "enemies": [
			{"type":"drone","health":300,"position":Vector2(COL0, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW1),time=10,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=20,shot_delay=0.5,init_delay=0.5,target=false,angular_rate=1,
					spawn_params={"amount":10,},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),type="sin",frequency=5,aplitude=2
					}}
				]
			},
			{"type":"drone","health":300,"position":Vector2(COL5, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW1),time=10,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL3, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=20,shot_delay=0.5,init_delay=0.5,target=false,angular_rate=1,
					spawn_params={"amount":10,},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),type="sin",frequency=5,aplitude=2
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 16.0, "enemies": [
			{"type":"drone","health":500,"position":Vector2(COL2+16, TOP),
				"movement": [
					{ point=Vector2(COL2+16, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=15.0 },
					{ point=Vector2(COL2+16, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=20,shot_delay=1.0,init_delay=0.5,target=false,
					spawn_params={"amount":20,},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("PURPLE")
					}},
					{ type="radial",cycles=20,shot_delay=1.0,init_delay=0.75,target=false,rotation=10,
					spawn_params={"amount":20,},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("CYAN")
					}}
				]
			},
			{"type":"plate","health":100,"position":Vector2(COL0, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=15.0 },
					{ point=Vector2(COL0, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=7,shot_delay=2.0,init_delay=0.5,target=true,
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=2.0
					}},
				]
			},
			{"type":"plate","health":100,"position":Vector2(COL5, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=15.0 },
					{ point=Vector2(COL5, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=7,shot_delay=2.0,init_delay=0.5,target=true,
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=2.0
					}},
				]
			},
		]
	})

	level.groups.append({
		"time": 6, "enemies": [
			{"type":"plate","health":30,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=5.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0+16, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL1, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL1+16, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL2, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL2+16, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3+16, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL4, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL4+16, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
			{"type":"plate","health":30,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5+16, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=3,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={"amount":5},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED"),
					}}
				]
			},
		]
	})

	level.groups.append({
		"time": 13.0, "enemies": [
			{"type":"dragonfly","health":800,"position":Vector2(COL2+16, TOP),
				"movement": [
					{ point=Vector2(COL2+16, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=15.0 },
					{ point=Vector2(COL2+16, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=30,shot_delay=0.5,init_delay=0.5,target=false,
					spawn_params={"amount":7,"degrees":120},
					bullet_data={
					velocity=100.0,acceleration=1.0,color=Color("CYAN")
					}},
					{ type="radial",cycles=15,shot_delay=1.0,init_delay=1.0,target=true,random=Vector2(-10,10),
					spawn_params={"amount":5,"degrees":30},
					bullet_data={
					velocity=50.0,acceleration=1.02,color=Color("RED"),size=0.5
					}},
				]
			},
			{"type":"plate","health":500,"position":Vector2(COL0, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=15.0 },
					{ point=Vector2(LEFT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=150,shot_delay=0.1,init_delay=0.5,target=false,rotation=-45,
					spawn_params={"amount":2,"degrees":120},
					bullet_data={
					velocity=400.0,acceleration=1.0,color=Color("PURPLE")
					}},
				]
			},
			{"type":"plate","health":500,"position":Vector2(COL0, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW6),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=15.0 },
					{ point=Vector2(LEFT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=150,shot_delay=0.1,init_delay=0.5,target=false,rotation=-120,
					spawn_params={"amount":2,"degrees":120},
					bullet_data={
					velocity=400.0,acceleration=1.0,color=Color("PURPLE")
					}},
				]
			},
			{"type":"plate","health":500,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=15.0 },
					{ point=Vector2(RIGHT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=150,shot_delay=0.1,init_delay=0.5,target=false,rotation=45,
					spawn_params={"amount":2,"degrees":120},
					bullet_data={
					velocity=400.0,acceleration=1.0,color=Color("PURPLE")
					}},
				]
			},
			{"type":"plate","health":500,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW6),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=15.0 },
					{ point=Vector2(RIGHT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=150,shot_delay=0.1,init_delay=0.5,target=false,rotation=120,
					spawn_params={"amount":2,"degrees":120},
					bullet_data={
					velocity=400.0,acceleration=1.0,color=Color("PURPLE")
					}},
				]
			},
		]
	})

	level.groups.append({
		"time": 1.0, "enemies": [
			{"type":"disk","health":200,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(RIGHT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.5,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
			{"type":"disk","health":200,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL0, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(LEFT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.75,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
		]
	})
	level.groups.append({
		"time": 1.0, "enemies": [
			{"type":"disk","health":200,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(RIGHT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.5,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
			{"type":"disk","health":200,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL0, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(LEFT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.75,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
		]
	})
	level.groups.append({
		"time": 1.0, "enemies": [
			{"type":"disk","health":200,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(RIGHT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.5,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
			{"type":"disk","health":200,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL0, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(LEFT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.75,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
		]
	})
	level.groups.append({
		"time": 1.0, "enemies": [
			{"type":"disk","health":200,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(RIGHT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.5,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
			{"type":"disk","health":200,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL0, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(LEFT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.75,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
		]
	})
	level.groups.append({
		"time": 7.0, "enemies": [
			{"type":"disk","health":200,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(RIGHT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.5,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
			{"type":"disk","health":200,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL0, ROW8),time=6,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_IN,pause=0.0 },
					{ point=Vector2(LEFT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=4,shot_delay=2,init_delay=0.75,target=true,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=75.0,acceleration=1.0,color=Color("RED"),size=1.5,lifetime=30
					}},
				]
			},
		]
	})

	level.groups.append({
		"time": 10.0, "enemies": [
			{"type":"drone","health":500,"position":Vector2(COL2+16, TOP),
				"movement": [
					{ point=Vector2(COL2+16, TOP),time=1.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2+16, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=10.0 },
					{ point=Vector2(COL2+16, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=200,shot_delay=0.05,init_delay=1.5,target=false,angular_rate=3,
					spawn_params={"amount":4},
					bullet_data={
					velocity=200.0,acceleration=1.0,color=Color("RED")
					}},
				]
			},

			{"type":"disk","health":200,"position":Vector2(COL0, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=21.0 },
					{ point=Vector2(COL0, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=2000,shot_delay=.1,init_delay=0.5,target=false,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=200.0,acceleration=1.0,color=Color("CYAN"),type="sin",frequency=10,aplitude=1,size=0.5
					}},
				]
			},
			{"type":"disk","health":200,"position":Vector2(COL1, TOP),
				"movement": [
					{ point=Vector2(COL1, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=11.0 },
					{ point=Vector2(COL1, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1000,shot_delay=.1,init_delay=0.5,target=false,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=200.0,acceleration=1.0,color=Color("CYAN"),type="sin",frequency=10,aplitude=1,size=0.5
					}},
				]
			},
			{"type":"disk","health":200,"position":Vector2(COL4, TOP),
				"movement": [
					{ point=Vector2(COL4, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=11.0 },
					{ point=Vector2(COL4, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1000,shot_delay=.1,init_delay=0.5,target=false,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=200.0,acceleration=1.0,color=Color("CYAN"),type="sin",frequency=10,aplitude=1,size=0.5
					}},
				]
			},
						{"type":"disk","health":200,"position":Vector2(COL4, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=21.0 },
					{ point=Vector2(COL5, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=2000,shot_delay=.1,init_delay=0.5,target=false,random=Vector2(-5,5),
					spawn_params={},
					bullet_data={
					velocity=200.0,acceleration=1.0,color=Color("CYAN"),type="sin",frequency=10,aplitude=1,size=0.5
					}},
				]
			},
		]
	})

	level.groups.append({
		"time": 13.0, "enemies": [
			{"type":"disk","health":300,"position":Vector2(COL2, TOP),
				"movement": [
					{ point=Vector2(COL2, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=10.0 },
					{ point=Vector2(COL2, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=200,shot_delay=0.2,init_delay=1.5,target=false,random=Vector2(-10,10),
					spawn_params={"amount":12},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}},
				]
			},
			{"type":"disk","health":300,"position":Vector2(COL3, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.1,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=00.0 },
					{ point=Vector2(COL3, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=10.0 },
					{ point=Vector2(COL3, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=200,shot_delay=0.2,init_delay=1.6,target=false,random=Vector2(-10,10),
					spawn_params={"amount":12},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}},
				]
			},
		]
	})

	level.groups.append({
		"time": 23.0, "enemies": [
			{"type":"dragonfly","health":1500,"position":Vector2(COL2+16, TOP),
				"movement": [
					{ point=Vector2(COL2+16, TOP),time=0.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2+16, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=20.0 },
					{ point=Vector2(COL2+16, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=200,shot_delay=0.3,init_delay=0.5,target=false,angular_rate=.5,
					spawn_params={"amount":20},
					bullet_data={
					velocity=100.0,acceleration=1.0,color=Color("PURPLE"),type="sin",frequency=1,amplitude=1,
					}},
					{ type="linear",cycles=100,shot_delay=.7,init_delay=0.5,target=true,
					spawn_params={"amount":10,"angle":120},
					bullet_data={
					velocity=400.0,acceleration=.98,color=Color("RED"),size=2
					}},
				]
			},
		]
	})


	level.start_level(0) #13
