extends Node

const BULLET = preload("res://Scenes/Bullet.tscn")
const SIZE: int = 5000
var idx: int = -1

var pool = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in SIZE:
		pool.append(BULLET.instantiate())
		add_child(pool[i])
		pool[i].enable(false)

func bullet():
	idx = wrapi(idx + 1, 0, SIZE)
	pool[idx].enable(true)
	return pool[idx]
