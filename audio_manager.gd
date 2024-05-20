extends AudioStreamPlayer

# this object manages itself for the master bus, then two sub-players for the player sfx bus and the "other sfx" bus

@onready var soundtrack_player := AudioStreamPlayer.new()
@onready var player_sfx_player := AudioStreamPlayer.new()
@onready var other_sfx_player := AudioStreamPlayer.new()
@onready var enemy_death_sfx := preload("res://Resources/Audio/SFX/explosion.ogg")
@onready var player_death_sfx := preload("res://Resources/Audio/SFX/wasted.ogg")
@onready var buy_share_sfx := preload("res://Resources/Audio/SFX/buybuybuy.ogg")
@onready var sell_share_sfx := preload("res://Resources/Audio/SFX/chaching.ogg")

func _ready() -> void:
	soundtrack_player.bus = "Soundtrack"
	add_child(soundtrack_player)

	other_sfx_player.bus = "Other SFX"
	other_sfx_player.max_polyphony = 10
	add_child(other_sfx_player)

	player_sfx_player.bus = "Player SFX"
	player_sfx_player.max_polyphony = 10
	add_child(player_sfx_player)

func set_soundtrack(s: Resource) -> void:
	soundtrack_player.stream = s

func play_soundtrack() -> void:
	soundtrack_player.playing = true

func stop_soundtrack() -> void:
	soundtrack_player.stop()

func add_soundtrack_lpf() -> void:
	pass

func remove_soundtrack_lpf() -> void:
	pass

func play_enemy_death_sfx() -> void:
	other_sfx_player.stream = enemy_death_sfx
	other_sfx_player.playing = true

func play_player_death_sfx() -> void:
	player_sfx_player.stream = player_death_sfx
	player_sfx_player.playing = true

func play_sell_share_sfx() -> void:
	other_sfx_player.stream = sell_share_sfx
	other_sfx_player.playing = true

func play_buy_share_sfx() -> void:
	other_sfx_player.stream = buy_share_sfx
	other_sfx_player.playing = true
