extends Node2D

@onready var soundtrack_player := $SoundtrackPlayer

func _ready() -> void:
	soundtrack_player.stream = load("res://Resources/Audio/Music/Tsumi.ogg")
	soundtrack_player.playing = true
