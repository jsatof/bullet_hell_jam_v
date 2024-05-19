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
		"time": 10.0, "enemies": [
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL1, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.3 },
					{ point=Vector2(COL5, ROW2),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(LEFT, ROW8),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=0.8,init_delay=0.5,target=true,
					spawn_params={},
					bullet_data={
					velocity=100.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(COL2, TOP),
				"movement": [
					{ point=Vector2(COL2, TOP),time=0.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=3.0 },
					{ point=Vector2(COL2, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.3 },
					{ point=Vector2(COL2, ROW7),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(LEFT, ROW8),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=3.5,init_delay=0.5,target=true,
					spawn_params={},
					bullet_data={
					velocity=100.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, TOP),time=0.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=6.0 },
					{ point=Vector2(COL5, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.3 },
					{ point=Vector2(COL5, ROW6),time=5,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW7),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=6.5,init_delay=0.5,target=true,
					spawn_params={},
					bullet_data={
					velocity=100.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 11.0, "enemies": [
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(LEFT, TOP),time=0.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW2),time=5.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=1.2,init_delay=0.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
						{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(LEFT, TOP),time=1.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW2),time=5.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=1.2,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(LEFT, TOP),time=2.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW2),time=5.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=1.2,init_delay=2.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(LEFT, TOP),time=3.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW2),time=5.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=1.2,init_delay=3.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(LEFT, TOP),time=4.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW2),time=5.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=1.2,init_delay=4.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(LEFT, TOP),time=5.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL1, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW2),time=5.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=10,shot_delay=1.2,init_delay=5.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 3.5, "enemies": [
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=1.5,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.3,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=1.8,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.6,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=2.1,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.9,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=2.4,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=1.2,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=2.7,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=1.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL4, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(RIGHT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=3.0,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 3.5, "enemies": [
			{"type":"plate","health":20,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(LEFT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=1.5,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.3,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(LEFT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=1.8,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.6,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(LEFT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=2.1,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=0.9,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(LEFT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=2.4,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=1.2,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(LEFT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=2.7,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, TOP),time=1.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL2, ROW8),time=2.0,trans=Tween.TRANS_LINEAR,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(LEFT, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=1,shot_delay=3.0,init_delay=1.5,random=Vector2(-5,5),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 6, "enemies": [
			{"type":"plate","health":50,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0, TOP),time=0.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL0, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=10,shot_delay=.8,init_delay=1.5,target=true,
					spawn_params={"amount":3, "degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":50,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, TOP),time=0.0,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=0.0 },
					{ point=Vector2(COL5, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=10,shot_delay=.8,init_delay=1.5,target=true,
					spawn_params={"amount":3, "degrees":30},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 10, "enemies": [
			{"type":"plate","health":20,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL0+16, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL1, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL1+16, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(LEFT, TOP),
				"movement": [
					{ point=Vector2(COL2, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(LEFT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL2+16, ROW3),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL3+16, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL4, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL4+16, ROW0),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5, ROW2),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
			{"type":"plate","health":20,"position":Vector2(RIGHT, TOP),
				"movement": [
					{ point=Vector2(COL5+16, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=8.0 },
					{ point=Vector2(RIGHT, TOP),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="linear",cycles=5,shot_delay=1.5,init_delay=1.5,random=Vector2(-10,10),target=true,
					spawn_params={},
					bullet_data={
					velocity=150.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})
	level.groups.append({
		"time": 10, "enemies": [
			{"type":"drone","health":200,"position":Vector2(COL2, TOP),
				"movement": [
					{ point=Vector2(COL2+16, ROW1),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_OUT,pause=10.0 },
					{ point=Vector2(LEFT, BOTTOM),time=0.5,trans=Tween.TRANS_SINE,ease=Tween.EASE_IN,pause=0.0 },
				],
				"spawners": [
					{ type="radial",cycles=20,shot_delay=0.2,init_delay=0.5,target=false,angular_rate=1,
					spawn_params={"amount":20},
					bullet_data={
					velocity=100.0,acceleration=1.0,color=Color("RED")
					}}
				]
			},
		]
	})

	level.start_level(0) #8
