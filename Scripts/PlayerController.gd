extends Area2D

const SPAWNER = preload("res://Scripts/Spawner.gd")

@onready var globals := $'/root/GlobalState'
@onready var bullet_pool := get_tree().get_first_node_in_group("pools")
@onready var bullet_collider := $'BulletCollider'
@onready var sprite := $'PlayerSprite'
@onready var hit_timer := $'HitTimer'

@onready var audio_manager := get_node("/root/AudioManager")
@onready var audio_player := AudioStreamPlayer.new()
@onready var shoot_sfx: Resource = globals.current_weapon["shootsound"]
@onready var hurt_sfx := preload("res://Resources/Audio/SFX/hit_sound_1_boosted.ogg")
@onready var death_sfx := preload("res://Resources/Audio/SFX/wasted.ogg")
@onready var equip_sfx := preload("res://Resources/Audio/SFX/gun_purchase.ogg")
@onready var panner := AudioServer.get_bus_effect(AudioServer.get_bus_index("Player SFX"), 0)

const FLASH_INTERVAL = 0.1
var sprite_visible := true

var normal_speed := 200.0
var focus_speed := 50.0

var flash_timer: Timer
var invincible := false

@onready var weapon := SPAWNER.new()

signal player_hit

func _ready() -> void:
	globals.connect("weapon_equipped", _on_weapon_equipped)

	self.add_child(weapon)

	flash_timer = Timer.new()
	flash_timer.wait_time = FLASH_INTERVAL
	flash_timer.one_shot = false
	flash_timer.timeout.connect(_on_sprite_flash)
	add_child(flash_timer)

	globals.player_died.connect(_on_player_died)
	globals.new_weapon_equipped.connect(_on_new_weapon_equipped)

	audio_player.bus = "Player SFX"
	add_child(audio_player)

func _process(delta: float) -> void:
	var input := Input.get_vector("player-move_left", "player-move_right", "player-move_up", "player-move_down")
	var move_speed := focus_speed if Input.is_action_pressed("player-focus") else normal_speed
	var velocity := input * delta * move_speed
	position += velocity
	position = position.clamp(-globals.playspace, globals.playspace)

	if Input.is_action_pressed("player-fire"):
		if !invincible:
			fire()

func fire() -> void:
	weapon.fire()

	audio_player.stream = shoot_sfx
	panner.pan = pos_to_pan(global_position.x)
	audio_player.playing = true

	globals.update_bullet_counter()

func pos_to_pan(x_pos: float) -> float:
	return remap(x_pos, -globals.playspace.x, globals.playspace.x, -0.5, 0.5)

func _on_shot_timer_timeout() -> void:
	can_fire = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") && !invincible:
		globals.take_damage()
		player_hit.emit()

		audio_player.stream = hurt_sfx
		audio_player.playing = true

func _on_player_hit() -> void:
	invincible = true # could not set bullet collider to disabled and get expected result...
	flash_timer.start()
	hit_timer.start()

func _on_hit_timer_timeout() -> void:
	invincible = false
	flash_timer.stop()
	sprite.visible = true

func _on_sprite_flash() -> void:
	sprite_visible = !sprite_visible
	sprite.visible = sprite_visible

func _on_bullet_collecter_area_entered(area: Area2D) -> void:
	if area.is_in_group("money"):
		area.collect()

func _on_player_died() -> void:
	audio_manager.play_player_death_sfx()

func _on_weapon_equipped() -> void:
	weapon.reset()
	weapon.set_spawner_data(globals.current_weapon)
	weapon.activate()

	audio_player.stream = equip_sfx
	audio_player.playing = true
	shoot_sfx = globals.current_weapon["shootsound"]
