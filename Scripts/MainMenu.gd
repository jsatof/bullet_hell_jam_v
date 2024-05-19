extends Control

@onready var globals := get_node("/root/GlobalState")
@onready var start_button := $FartButton

func _ready() -> void:
	start_button.button_down.connect(on_start_button_pressed)

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("buy_gun")):
		start()

func on_start_button_pressed() -> void:
	start()

func start() -> void:
	globals.start_new_game()
