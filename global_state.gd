extends Node

@onready var audio_manager := get_node("/root/AudioManager")

const playspace := Vector2(384.0/4, 288.0/2 - 10)
const scrap_value := 10

const money_speed := 50.0
const money_exponent := 1.5
var max_lives := 50
var lives := max_lives
var money := 1000.0

var bullets_fired := 0
var bullets_hit := 0

var heckler_percent_diff := 5.0
var heckler_stock_price := 23.23
var last_heckler_stock_price := 23.23
var heckler_shares_owned := 0

var stock_rng := RandomNumberGenerator.new()
var bullet_rng := RandomNumberGenerator.new()

signal money_added
signal player_died
signal weapon_equipped

enum EndScreenState {
	LEVEL_CLEAR,
	VICTORY,
	DEFEAT,
	YOU_DIED,
}
var end_screen_state: EndScreenState = EndScreenState.YOU_DIED

# Fixed fire rate as of now. Can tie to weapon if desired
const fire_rate := 0.05
const bullet_speed := 300.0

const pea_shooter_gun := {
	"name": "Pea Shooter",
	"damage": 10.0,
	"shootsound": preload("res://Resources/Audio/SFX/pea_shooter_sound.ogg")
	"shopprice": 50000.0,
	"ammo": 100,
	"shot_delay": 0.2,
	"rotation": 180,
	"friend": true,
	"type": "linear",
	"spawn_params": {},
	"bullet_data": {
		"velocity": 300.0,
		"color": Color("YELLOW"),
		"size": 1.0,
		"acceleration": 1.0,
		"movement": "linear",
	}
}
const bigger_gun := {
	"name": "Bigger Gun",
	"damage": 25.0,
	"shopprice": 500.0,
	"shootsound": preload("res://Resources/Audio/SFX/shoot_sound_2.ogg")
	"ammo": 200,
	"bullet_speed": 400,
	"shot_delay": 0.08,
	"rotation": 180,
	"friend": true,
	"type": "linear",
	"spawn_params": {},
	"bullet_data": {
		"velocity": 300.0,
		"color": Color("RED"),
		"size": 1.0,
		"acceleration": 1.0,
		"frequency": 20,
		"amplitude": 3,
		"movement": "sin",
	}
}
var current_weapon: Dictionary = pea_shooter_gun
var current_purchasable_weapon: Dictionary = bigger_gun

func _ready() -> void:
	stock_rng.seed = 42069 # TODO: remove me when finalizing
	bullet_rng.seed = int("2hu")

func set_new_heckler_stock_price() -> void:
	last_heckler_stock_price = heckler_stock_price
	heckler_stock_price = stock_rng.randf() * 50.0 + 40.0 # range from [40.0, 90.0)
	heckler_percent_diff = heckler_stock_price - last_heckler_stock_price / heckler_stock_price * 100.0

func buy_heckler_stock() -> bool:
	if money < heckler_stock_price:
		return false
	heckler_shares_owned += 1
	money -= heckler_stock_price
	audio_manager.play_buy_share_sfx()
	return true

func sell_heckler_stock() -> bool:
	if heckler_shares_owned <= 0:
		return false
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
	new_weapon_equipped.emit()
	return true

func equip_weapon(weapon):
	current_weapon = weapon
	weapon_equipped.emit()

func update_bullet_counter() -> void:
	bullets_fired += 1

func get_accuracy() -> float:
	if bullets_fired == 0:
		return 100.0
	return float(bullets_hit) / float(bullets_fired) * 100.0

func take_damage() -> void:
	lives -= 1
	if lives <= 0:
		player_died.emit()
		goto_end_screen()

func collect_scrap() -> void:
	add_money(scrap_value)

func start_level() -> void:
	equip_weapon(current_weapon)

func goto_end_screen() -> void:
	var end_scene := preload("res://Scenes/EndOfLevel.tscn").instantiate()
	get_tree().root.add_child(end_scene)
	end_screen_state = EndScreenState.YOU_DIED
	get_tree().get_first_node_in_group("level").queue_free()

func goto_main_menu(source: Node) -> void:
	var main_menu := preload("res://Scenes/MainMenu.tscn").instantiate()
	get_tree().root.add_child(main_menu)
	source.queue_free()
