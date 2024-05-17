extends Node

const playspace = Vector2(200.0, 500.0)
const scrap_value := 10

const money_speed := 600.0
const money_exponent := 1.5
var max_lives := 5
var lives := max_lives
var money := 1000.0

var hit_count := 0
var accuracy := 100.0
var bullets_fired := 0
var bullets_hit := 0

var heckler_percent_diff := 5.0
var heckler_stock_price := 23.23
var last_heckler_stock_price := 23.23
var bullet_price := 10.0
var heckler_shares_owned := 0

var stock_rng := RandomNumberGenerator.new()
var test_bullet_rng := RandomNumberGenerator.new()

# Fixed fire rate as of now. Can tie to weapon if desired
const fire_rate := 0.05
const bullet_speed := 1000.0

const pea_shooter_gun := {
	"id": 0,
	"name": "Pea Shooter",
	"damage": 10.0,
	"bulletcost": 10.0,
	"shopprice": 0.0,
}
const bigger_gun := {
	"id": 1,
	"name": "Bigger Gun",
	"damage": 25.0,
	"bulletcost": 25.0,
	"shopprice": 500.0,
}
var current_weapon: Dictionary = pea_shooter_gun
var current_purchasable_gun: Dictionary = bigger_gun

var pea_shooter_bullet_count := 0
var bigger_gun_bullet_count := 0
var total_bullet_count := 0

func _ready() -> void:
	stock_rng.seed = 42069 # TODO: remove me when finalizing
	test_bullet_rng.seed = int("2hu")

func set_new_heckler_stock_price() -> void:
	last_heckler_stock_price = heckler_stock_price
	heckler_stock_price = stock_rng.randf() * 50.0 + 40.0 # range from [40.0, 90.0)
	heckler_percent_diff = heckler_stock_price - last_heckler_stock_price / heckler_stock_price * 100.0

func buy_heckler_stock() -> void:
	heckler_shares_owned += 1
	money -= heckler_stock_price
	print("Bought Stock for $", heckler_stock_price)

func sell_heckler_stock() -> void:
	heckler_shares_owned -= 1
	money += heckler_stock_price
	print("Sold Stock for $", heckler_stock_price)

func add_money(x: float) -> void:
	money += x

func buy_and_equip_gun_from_shop() -> bool:
	if current_purchasable_gun["shopprice"] > money:
		return false
	current_weapon = current_purchasable_gun
	money -= current_weapon["shopprice"]
	return true

func simulate_bullet_fired() -> void:
	match current_weapon["id"]: # index 2 is the bullet cost
		0: pea_shooter_bullet_count += 1
		1: bigger_gun_bullet_count += 1

	total_bullet_count += 1

	if simulate_bullet_hit():
		hit_count += 1

	accuracy = float(hit_count) / float(total_bullet_count) * 100.0
	money -= current_weapon["bulletcost"]

func simulate_bullet_hit() -> bool:
	return test_bullet_rng.randi() % 2 == 0

func get_accuracy() -> float:
	return accuracy
