extends Node

signal player_died

const playspace = Vector2(400.0, 500.0)
const scrap_value := 10

const money_speed := 600.0
const money_exponent := 1.5
var max_lives := 5
var lives := max_lives
var money := 1000.0

var bullets_fired := 0
var bullets_hit := 0

var heckler_percent_diff := 5.0
var heckler_stock_price := 23.23
var last_heckler_stock_price := 23.23
var bullet_price := 10.0
var heckler_shares_owned := 0

var stock_rng := RandomNumberGenerator.new()
var bullet_rng := RandomNumberGenerator.new()

signal money_added

enum EndScreenState {
	LEVEL_CLEAR,
	VICTORY,
	DEFEAT,
	YOU_DIED,
}
var end_screen_state: EndScreenState = EndScreenState.YOU_DIED

# Fixed fire rate as of now. Can tie to weapon if desired
const fire_rate := 0.05
const bullet_speed := 1000.0

var weapons := {
	"pea_shooter": {
		"id": 0,
		"name": "Pea Shooter",
		"damage": 10.0,
		"shopprice": 0.0,
		"shootsound": preload("res://Resources/Audio/SFX/pea_shooter_sound.ogg"),
		"spawner": preload("res://Scripts/Spawner.gd").new(),
	},
	"bigger_gun": {
		"id": 1,
		"name": "Bigger Gun",
		"damage": 25.0,
		"shopprice": 500.0,
		"shootsound": preload("res://Resources/Audio/SFX/pea_shooter_sound.ogg"),
		"spawner": preload("res://Scripts/Spawner.gd").new(),
	},
}

var current_weapon: Dictionary = weapons["pea_shooter"]
var current_purchasable_weapon: Dictionary = weapons["bigger_gun"]

func _ready() -> void:
	stock_rng.seed = 42069 # TODO: remove me when finalizing
	bullet_rng.seed = int("2hu")

	init_weapons()

func set_new_heckler_stock_price() -> void:
	last_heckler_stock_price = heckler_stock_price
	heckler_stock_price = stock_rng.randf() * 50.0 + 40.0 # range from [40.0, 90.0)
	heckler_percent_diff = heckler_stock_price - last_heckler_stock_price / heckler_stock_price * 100.0

func buy_heckler_stock() -> bool:
	if money < heckler_stock_price:
		return false
	heckler_shares_owned += 1
	money -= heckler_stock_price
	print("Bought Stock for $", heckler_stock_price)
	return true

func sell_heckler_stock() -> bool:
	if heckler_shares_owned <= 0:
		return false
	heckler_shares_owned -= 1
	money += heckler_stock_price
	print("Sold Stock for $", heckler_stock_price)
	return true

func add_money(x: float) -> void:
	money += x
	money_added.emit()

func buy_and_equip_gun_from_shop() -> bool:
	if current_purchasable_weapon["shopprice"] > money:
		return false
	current_weapon = current_purchasable_weapon
	money -= current_weapon["shopprice"]
	return true

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

func collect_scrap() -> void:
	add_money(scrap_value)

func goto_end_screen(source: Node) -> void:
	var end_scene := preload("res://Scenes/EndOfLevel.tscn").instantiate()
	get_tree().root.add_child(end_scene)
	source.queue_free()

func goto_main_menu(source: Node) -> void:
	var main_menu := preload("res://Scenes/MainMenu.tscn").instantiate()
	get_tree().root.add_child(main_menu)
	source.queue_free()

func init_weapons() -> void:
	weapons["pea_shooter"]["spawner"].set_spawner_data(
		{ type="radial",cycles=10,shot_delay=0.1,init_delay=0.5,rotation=20,angular_rate=1,target=false,
					spawn_params={"amount":15},
					bullet_data={
						velocity=400.0,color=Color("PURPLE"),movement="sin",amplitude=3,frequency=5
					}})

	weapons["bigger_gun"]["spawner"].set_spawner_data(
		{ type="radial",cycles=10,shot_delay=0.1,init_delay=0.5,rotation=20,angular_rate=1,target=false,
					spawn_params={"amount":15},
					bullet_data={
						velocity=400.0,color=Color("PURPLE"),movement="sin",amplitude=3,frequency=5
					}})
