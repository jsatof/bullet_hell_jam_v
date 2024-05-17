extends Area2D

@onready var globals = get_node("/root/GlobalState")
@onready var player = get_tree().get_first_node_in_group("Player")
var collected := false
var t := 0.0

signal money_collected

func _process(delta: float) -> void:
	position += transform.y * globals.money_speed * delta

	if collected:
		t += delta * 0.6
		position = position.lerp(player.position, t)
		if t >= 0.1:
			money_collected.emit()
			globals.money += globals.scrap_value
			print("CASH MONEY")
			remove()

	if global_position.y >= globals.playspace.y + 20:
		remove()

func collect() -> void:
	collected = true

func remove() -> void:
	queue_free()
