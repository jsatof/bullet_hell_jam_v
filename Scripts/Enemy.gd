extends Area2D

@onready var audio_manager := get_node("/root/AudioManager")

const SPAWNER = preload("res://Scripts/Spawner.gd")
@onready var globals = get_node("/root/GlobalState")
@onready var pool = get_tree().get_first_node_in_group("pools")

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
		self.add_child(spawner)
		spawner.set_spawner_data(s)
		spawner.activate_and_auto_fire()

func drop_money() -> void:
	for i in range(max_health/25 + pow(max_health/100, globals.money_exponent)):
		var x = position.x + globals.bullet_rng.randi_range(-25, 25)
		var y = position.y + globals.bullet_rng.randi_range(-25, 25)
		var m = pool.money()
		m.position = Vector2(x, y)

func remove_self() -> void:
	self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		globals.bullets_hit += 1
		enemy_hit.emit()
		area.enable(false)

func _on_enemy_hit() -> void:
	# TODO If a gun is changed the bullets that are on screen will also
	# 	damage according to the new gun. Not a big deal and an easy fix if needed
	health -= globals.current_weapon["damage"]
	if health <= 0:
		enemy_killed.emit()

func _on_enemy_killed() -> void:
	drop_money()
	audio_manager.play_enemy_death_sfx()
	remove_self()
