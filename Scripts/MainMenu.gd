extends Control

@onready var start_button := $FartButton

func _ready() -> void:
	start_button.button_down.connect(on_start_button_pressed)

func on_start_button_pressed() -> void:
	var next_scene := preload("res://Scenes/TestLevel.tscn").instantiate()
	get_tree().root.add_child(next_scene)
	self.queue_free()
