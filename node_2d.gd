extends Node2D

@onready var player := $Player


var dx = 10
var radius = 10
var pos := get_viewport_rect().size
var my_rect := Rect2(pos.x / 2 - 10, pos.y / 2 - 10, 10, 10)

func _process(delta):
	my_rect.position.x = pos.x + 1.0 * radius * sin(delta * 0.04)
	my_rect.position.y = pos.y + 1.0 * radius * cos(delta * 0.04)

	queue_redraw()

func _draw():
	draw_rect(my_rect, Color.GREEN)

