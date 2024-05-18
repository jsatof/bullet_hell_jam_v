extends Area2D

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

var shot_timer: Timer
var flash_timer: Timer
var can_fire := true
var invincible := false

signal player_hit

func _ready() -> void:
	shot_timer = Timer.new()
	shot_timer.wait_time = globals.fire_rate
	shot_timer.one_shot = true
	shot_timer.timeout.connect(_on_shot_timer_timeout)
	add_child(shot_timer)

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
		if can_fire && !invincible:
			fire()

func fire() -> void:
	# TODO move parameters to weapon data
	var b = bullet_pool.player_bullet()
	b.position = self.global_position
	b.set_color(Color("YELLOW"))
	b.velocity = globals["bullet_speed"]
	b.lifetime = 2
	b.rotation = -PI/2 # Rotate 90 degrees for upward firing

	audio_player.stream = shoot_sfx
	panner.pan = pos_to_pan(global_position.x)
	audio_player.playing = true

	globals.update_bullet_counter()
	can_fire = false
	shot_timer.start()

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

func _on_new_weapon_equipped() -> void:
	audio_player.stream = equip_sfx
	audio_player.playing = true
	shoot_sfx = globals.current_weapon["shootsound"]
