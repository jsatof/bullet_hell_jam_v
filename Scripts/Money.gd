extends Area2D

@onready var globals = get_node("/root/GlobalState")

func _process(delta: float) -> void:
	position += transform.y * globals.money_speed * delta

	if global_position.y >= globals.playspace.y + 20:
		queue_free()
