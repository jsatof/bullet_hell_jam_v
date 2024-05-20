extends Node

# TODO seperate player bullet
# TODO allow for different sprites for enemy bullets
const ENEMY_BULLET := preload("res://Scenes/Bullet.tscn")
const ENEMY_SIZE := 2000
var enemy_idx := -1
var enemy_pool := []

const PLAYER_BULLET := preload("res://Scenes/PlayerBullet.tscn")
const PLAYER_SIZE := 150
var player_idx := -1
# Was going to call it p_pool, but I don't p in the pool
var player_pool := []

const MONEY := preload("res://Scenes/Money.tscn")
const MONEY_SIZE := 200
var money_idx = -1
var money_pool = []

func _ready() -> void:
	for i in ENEMY_SIZE:
		enemy_pool.append(ENEMY_BULLET.instantiate())
		add_child(enemy_pool[i])
		enemy_pool[i].add_to_group("enemy")

	for i in PLAYER_SIZE:
		player_pool.append(PLAYER_BULLET.instantiate())
		add_child(player_pool[i])
		player_pool[i].add_to_group("player_bullet")

	for i in MONEY_SIZE:
		money_pool.append(MONEY.instantiate())
		add_child(money_pool[i])
		money_pool[i].add_to_group("money")

func bullet():
	enemy_idx = wrapi(enemy_idx + 1, 0, ENEMY_SIZE)
	enemy_pool[enemy_idx].enable(true)
	return enemy_pool[enemy_idx]

func player_bullet():
	player_idx = wrapi(player_idx + 1, 0, PLAYER_SIZE)
	player_pool[player_idx].enable(true)
	return player_pool[player_idx]

func money():
	money_idx = wrapi(money_idx + 1, 0, MONEY_SIZE)
	money_pool[money_idx].enable(true)
	return money_pool[money_idx]
