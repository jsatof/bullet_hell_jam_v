extends AudioStreamPlayer

# this object manages itself for the master bus, then two sub-players for the player sfx bus and the "other sfx" bus

@onready var soundtrack_player := AudioStreamPlayer.new()
@onready var player_sfx_player := AudioStreamPlayer.new()
@onready var other_sfx_player := AudioStreamPlayer.new()
@onready var ogg_stream := AudioStreamOggVorbis.load_from_file("res://Resources/Audio/Music/Tsumi.ogg")
@onready var enemy_death_sfx := preload("res://Resources/Audio/SFX/explosion.ogg")
@onready var player_death_sfx := preload("res://Resources/Audio/SFX/wasted.ogg")
@onready var buy_share_sfx := preload("res://Resources/Audio/SFX/buybuybuy.ogg")
@onready var sell_share_sfx := preload("res://Resources/Audio/SFX/chaching.ogg")

func _ready() -> void:
	soundtrack_player.bus = "Soundtrack"
	set_soundtrack(ogg_stream)
	add_child(soundtrack_player)

func set_soundtrack(stream: AudioStreamOggVorbis) -> void:
	soundtrack_player.stream = stream
	soundtrack_player.stream.loop = true

	other_sfx_player.bus = "Other SFX"
	add_child(other_sfx_player)

	player_sfx_player.bus = "Player SFX"
	add_child(player_sfx_player)

func play_soundtrack() -> void:
	soundtrack_player.playing = true

func add_soundtrack_lpf() -> void:
	pass

func remove_soundtreack_lpf() -> void:
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
