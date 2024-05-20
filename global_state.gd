extends Node

var level_1 := preload("res://Scenes/Level1.tscn")
var level_2 := preload("res://Scenes/Level2.tscn")

@onready var audio_manager := get_node("/root/AudioManager")

const playspace := Vector2(384.0/4, 288.0/2 - 10)
const scrap_value := 10

const money_speed := 50.0
const money_exponent := 1.5
var max_lives := 5
var lives := max_lives
var starting_money := 1000000.0
var money := starting_money

var bullets_fired := 0
var bullets_hit := 0
var max_ammo := 100
var current_ammo := max_ammo

var heckler_percent_diff := 5.0
var heckler_stock_price := 23.23
var last_heckler_stock_price := 23.23
var heckler_shares_owned := 0
const max_trades := 10
var trades_remaining := max_trades

var current_level := 1

var stock_rng := RandomNumberGenerator.new()
var bullet_rng := RandomNumberGenerator.new()

signal money_added
signal player_died
signal player_damaged
signal weapon_equipped
signal weapon_fired

enum EndScreenState {
	LEVEL_CLEAR,
	VICTORY,
	DEFEAT,
	YOU_DIED,
}
var end_screen_state: EndScreenState = EndScreenState.YOU_DIED

const Ol_Reliable := {
	"name": "Ol'Reliable",
	"damage": 10.0,
	"shootsound": preload("res://Resources/Audio/SFX/pea_shooter_sound.ogg"),
	"shopprice": 500.0,
	"cycles": 100,
	"shot_delay": 0.1,
	"rotation": 180,
	"friend": true,
	"type": "linear",
	"bullet_data": {
		"velocity": 300.0,
		"color": Color("YELLOW"),
		"size": 1.0,
		"acceleration": 1.0,
		"type": "linear",
	}
}
const Scrapper := {
	"name": "Scrapper",
	"damage": 15.0,
	"shopprice": 750.0,
	"shootsound": preload("res://Resources/Audio/SFX/shoot_sound_2.ogg"),
	"cycles": 40,
	"bullet_speed": 400,
	"shot_delay": 0.08,
	"rotation": 180,
	"friend": true,
	"type": "linear",
	"bullet_data": {
		"velocity": 300.0,
		"color": Color("YELLOW"),
		"size": 1.0,
		"acceleration": 1.0,
		"frequency": 20,
		"amplitude": 3,
		"type": "linear",
	}
}
const Bertha := {
	"name": "Bertha",
	"damage": 50.0,
	"shopprice": 2000.0,
	"shootsound": preload("res://Resources/Audio/SFX/shoot_sound_2.ogg"),
	"cycles": 25,
	"bullet_speed": 200,
	"shot_delay": 0.1,
	"rotation": 180,
	"friend": true,
	"type": "linear",
	"bullet_data": {
		"velocity": 300.0,
		"color": Color("YELLOW"),
		"size": 2.0,
		"acceleration": 1.0,
		"frequency": 20,
		"amplitude": 3,
		"type": "linear",
	}
}
const Sawed_Off := {
	"name": "Sawed-Off",
	"damage": 15.0,
	"shopprice": 1000.0,
	"shootsound": preload("res://Resources/Audio/SFX/shoot_sound_2.ogg"),
	"cycles": 30,
	"bullet_speed": 200,
	"shot_delay": 0.2,
	"rotation": 180,
	"friend": true,
	"type": "radial",
	"random": Vector2(-2, 2),
	"spawn_params": {
		"amount":3,
		"degrees":30,
	},
	"bullet_data": {
		"velocity": 500.0,
		"color": Color("YELLOW"),
		"size": 1.0,
		"acceleration": 1.0,
		"frequency": 20,
		"amplitude": 3,
		"type": "linear",
	}
}
const Minigun := {
	"name": "Minigun",
	"damage": 2.0,
	"shopprice": 1000.0,
	"shootsound": preload("res://Resources/Audio/SFX/shoot_sound_2.ogg"),
	"cycles": 500,
	"bullet_speed": 200,
	"shot_delay": 0.02,
	"rotation": 180,
	"friend": true,
	"type": "radial",
	"random": Vector2(-5, 5),
	"spawn_params": {
		"amount":2,
		"degrees":10,
	},
	"bullet_data": {
		"velocity": 400.0,
		"color": Color("YELLOW"),
		"size": 0.5,
		"acceleration": 1.0,
		"frequency": 20,
		"amplitude": 3,
		"type": "linear",
	}
}
const Bendy := {
	"name": "Bendy",
	"damage": 20.0,
	"shopprice": 1000.0,
	"shootsound": preload("res://Resources/Audio/SFX/shoot_sound_2.ogg"),
	"cycles": 150,
	"bullet_speed": 450,
	"shot_delay": 0.08,
	"rotation": 180,
	"friend": true,
	"type": "linear",
	"spawn_params": {
	},
	"bullet_data": {
		"velocity": 400.0,
		"color": Color("YELLOW"),
		"size": 1.0,
		"acceleration": 1.0,
		"frequency": 20,
		"amplitude": 4,
		"type": "sin",
	}
}
const Collster := {
	"name": "Collster",
	"damage": 25.0,
	"shopprice": 1000.0,
	"shootsound": preload("res://Resources/Audio/SFX/shoot_sound_2.ogg"),
	"cycles": 10000,
	"bullet_speed": 800,
	"shot_delay": 0.01,
	"rotation": 180,
	"friend": true,
	"type": "linear",
	"spawn_params": {
	},
	"bullet_data": {
		"velocity": 400.0,
		"color": Color("YELLOW"),
		"size": 0.5,
		"acceleration": 0.93,
		"lifetime": 0.1,
		"frequency": 20,
		"amplitude": 2,
		"type": "linear",
	}
}

var current_weapon: Dictionary = Bendy
var current_purchasable_weapon: Dictionary = Scrapper

const weapon_list := [
	Ol_Reliable,
	Scrapper,
	Bertha,
	Sawed_Off,
	Minigun,
	Bendy,
	Collster
]

func _ready() -> void:
	stock_rng.seed = 42069 # TODO: remove me when finalizing
	bullet_rng.seed = int("2hu")

func set_new_heckler_stock_price() -> void:
	last_heckler_stock_price = heckler_stock_price
	heckler_stock_price = stock_rng.randf() * 50.0 + 40.0 # range from [40.0, 90.0)
	heckler_percent_diff = heckler_stock_price - last_heckler_stock_price / heckler_stock_price * 100.0

func buy_heckler_stock() -> bool:
	if money < heckler_stock_price || trades_remaining <= 0:
		return false
	trades_remaining -= 1
	heckler_shares_owned += 1
	money -= heckler_stock_price
	audio_manager.play_buy_share_sfx()
	return true

func sell_heckler_stock() -> bool:
	if heckler_shares_owned <= 0 || trades_remaining <= 0:
		return false
	trades_remaining -= 1
	heckler_shares_owned -= 1
	money += heckler_stock_price
	audio_manager.play_sell_share_sfx()
	return true

func add_money(x: float) -> void:
	money += x
	money_added.emit()

func buy_and_equip_gun_from_shop() -> bool:
	if current_purchasable_weapon["shopprice"] > money:
		return false
	equip_weapon(current_purchasable_weapon)
	money -= current_weapon["shopprice"]
	return true

func reset_trade_count():
	trades_remaining = max_trades

func equip_weapon(weapon):
	current_weapon = weapon
	max_ammo = current_weapon.cycles
	current_ammo = max_ammo
	weapon_equipped.emit()

func update_bullet_counter() -> void:
	current_ammo -= 1
	bullets_fired += 1
	weapon_fired.emit()

func get_ammo_percent() -> float:
	return  float(current_ammo) / max_ammo

func get_accuracy() -> float:
	if bullets_fired == 0:
		return 100.0
	return float(bullets_hit) / float(bullets_fired) * 100.0

func take_damage() -> void:
	lives -= 1
	if lives <= 0:
		player_died.emit()
		end_screen_state = EndScreenState.YOU_DIED
		goto_end_screen()
	player_damaged.emit()

func collect_scrap() -> void:
	add_money(scrap_value)

func reset_game() -> void:
	current_level = 0
	lives = max_lives
	money = starting_money
	bullets_fired = 0
	bullets_hit = 0
	trades_remaining = max_trades

func start_new_game() -> void:
	reset_game()
	load_next_level()
	start_level()

func load_next_level() -> void:
	current_level += 1
	match current_level:
		1:
			get_tree().change_scene_to_packed(level_1)
		2:
			get_tree().change_scene_to_packed(level_2)
		_:
			goto_main_menu()

func start_level() -> void:
	equip_weapon(current_weapon)

func finish_level() -> void:
	if current_level < 3:
		end_screen_state = EndScreenState.LEVEL_CLEAR
	else:
		end_screen_state = EndScreenState.VICTORY
	goto_end_screen()

func goto_end_screen() -> void:
	audio_manager.stop_soundtrack()
	var end_scene := preload("res://Scenes/EndOfLevel.tscn")
	get_tree().change_scene_to_packed(end_scene)

func goto_main_menu() -> void:
	var main_menu := preload("res://Scenes/MainMenu.tscn")
	get_tree().change_scene_to_packed(main_menu)

func get_random_weapon() -> Dictionary:
	var my_rng := RandomNumberGenerator.new()
	my_rng.randomize()
	var index := my_rng.randi() % len(weapon_list)
	return weapon_list[index]
