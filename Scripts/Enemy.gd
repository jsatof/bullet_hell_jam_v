extends Area2D

const SPAWNER = preload("res://Scripts/Spawner.gd")
const MONEY = preload("res://Scenes/Money.tscn")
@onready var globals = get_node("/root/GlobalState")
@onready var pool = get_node("../BulletPool")

var max_health := 100.0
var health := max_health
var movement_targets = []
var spawners = []

var current_target: int = 0

signal enemy_hit
signal enemy_killed

func _ready() -> void:
	current_target = 0
	move_to_targets()
	create_spawners()

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
		var spawner = SPAWNER.new()
		if s.has("cycles"):
			spawner.cycles = s.cycles
		if s.has("shot_delay"):
			spawner.shot_delay = s.shot_delay
		if s.has("init_delay"):
			spawner.init_delay = s.init_delay
		if s.has("offset"):
			spawner.offset = s.offset
		if s.has("rotation"):
			spawner.rotation_degrees = s.rotation
		if s.has("rotate_speed"):
			spawner.rotate_speed = s.rotate_speed
		self.add_child(spawner)
		spawner.set_type(s.type)
		spawner.spawn_params = s.spawn_params
		spawner.bullet_data = s.bullet_data
		spawner.activate()

func drop_money() -> void:
	for i in range(max_health/25 + pow(max_health/100, globals.money_exponent)):
		var x = position.x + randi_range(-100, 100)
		var y = position.y + randi_range(-100, 100)
		var m = MONEY.instantiate()
		m.position = Vector2(x, y)
		get_tree().root.add_child(m)

func remove_self() -> void:
	self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		enemy_hit.emit()

func _on_enemy_hit() -> void:
	health -= globals.current_weapon["damage"]
	if health <= 0:
		enemy_killed.emit()

func _on_enemy_killed() -> void:
	print("Killed enemy")
	drop_money()
	remove_self()

