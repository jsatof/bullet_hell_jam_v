extends Control

@onready var audio_manager := get_node("/root/AudioManager")
@onready var globals := get_node("/root/GlobalState")

func _ready() -> void:
	var main_menu_song := AudioStreamOggVorbis.load_from_file("res://Resources/Audio/Music/Reonidas.ogg")
	audio_manager.set_soundtrack(main_menu_song)
	audio_manager.add_soundtrack_lpf()
	audio_manager.play_soundtrack()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("buy_gun")):
		start()

func start() -> void:
	globals.start_new_game()
