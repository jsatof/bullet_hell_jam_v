extends Node

# TODO seperate player bullet
# TODO allow for different sprites for enemy bullets
const BULLET := preload("res://Scenes/Bullet.tscn")
const SIZE := 5000
var idx := -1

const PLAYER_SIZE := 20
var player_idx := -1

var pool := []
# Was going to call it p_pool, but I don't p in the pool
var player_pool := []

func _ready() -> void:
	for i in SIZE:
		pool.append(BULLET.instantiate())
		add_child(pool[i])
		pool[i].enable(false)
		pool[i].add_to_group("enemy")

	for i in PLAYER_SIZE:
		player_pool.append(BULLET.instantiate())
		add_child(player_pool[i])
		player_pool[i].enable(false)
		player_pool[i].add_to_group("player_bullet")

func bullet():
	idx = wrapi(idx + 1, 0, SIZE)
	pool[idx].enable(true)
	return pool[idx]

func player_bullet():
	player_idx = wrapi(player_idx + 1, 0, PLAYER_SIZE)
	player_pool[player_idx].enable(true)
	return player_pool[player_idx]
