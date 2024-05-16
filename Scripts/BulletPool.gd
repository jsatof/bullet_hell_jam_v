extends Node

const BULLET := preload("res://Scenes/Bullet.tscn")
const SIZE := 5000
var idx := -1

var pool := []

func _ready() -> void:
	for i in SIZE:
		pool.append(BULLET.instantiate())
		add_child(pool[i])
		pool[i].enable(false)

func bullet():
	idx = wrapi(idx + 1, 0, SIZE)
	pool[idx].enable(true)
	return pool[idx]
