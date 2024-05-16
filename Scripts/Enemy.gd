extends Area2D

var Spawner = preload("res://Scripts/Spawner.gd")
@onready var globals = get_node("/root/GlobalState")
@onready var pool = get_node("../BulletPool")

var health: float = 100.0
var velocity: float = 100.0
var lifetime: float = 5.0
var movement_targets = []
var spawners = []

var current_target: int = 0
var current_time: float = 0.0


func _ready():
	current_time = 0.0
	current_target = 0
	move_to_targets()
	create_spawners()

func _process(delta):
	current_time += delta

	if current_time >= lifetime:
		remove_self()

func move_to_targets() -> void:
	var move_tween = get_tree().create_tween()
	for t in movement_targets:
		move_tween.chain().tween_property(self,
			"position",
			t.point,
			t.time).set_trans(t.trans).set_ease(t.ease)
		move_tween.tween_interval(t.pause).finished

	await move_tween.finished
	remove_self()

func create_spawners() -> void:
	for s in spawners:
		var spawner = Spawner.new()
		if s.has("cycles"):
			spawner.cycles = s.cycles
		if s.has("shot_delay"):
			spawner.shot_delay = s.shot_delay
		if s.has("init_delay"):
			spawner.init_delay = s.init_delay
		if s.has("offset"):
			spawner.offset = s.offset
		self.add_child(spawner)
		spawner.set_type(s.type)
		spawner.spawn_params = s.spawn_params
		spawner.bullet_data = s.bullet_data
		spawner.activate()

func remove_self():
	print("gone")
	queue_free()