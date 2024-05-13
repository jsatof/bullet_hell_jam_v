extends Node

var bullet_count := 0
var hit_count := 0
var accuracy := 100.0
var money := 1000.0

var heckler_percent_diff := 5.0
var heckler_stock_price := 23.23
var last_heckler_stock_price := 23.23
var bullet_price := 10.0
var heckler_shares_owned := 0

var rng := RandomNumberGenerator.new()

var pea_shooter_gun := [
	"Pea Shooter", 	# Name
	100.0, 			# Damage
	10.0,			# Cost per shot
]
var bigger_gun := [
	"Bigger Gun",	# Name
	200.0,			# Damage
	25.0,			# Cost per shot
]
var current_gun: Array = pea_shooter_gun

func _ready():
	rng.seed = 42069 # TODO: remove me when finalizing
	set_new_heckler_stock_price()

func set_new_heckler_stock_price():
	last_heckler_stock_price = heckler_stock_price
	heckler_stock_price = rng.randf() * 50.0 + 40.0 # range from [40.0, 90.0)
	heckler_percent_diff = heckler_stock_price - last_heckler_stock_price / heckler_stock_price * 100.0

func buy_heckler_stock():
	heckler_shares_owned += 1
	money -= heckler_stock_price
	print("Bought Stock for $", heckler_stock_price)

func sell_heckler_stock():
	heckler_shares_owned -= 1
	money += heckler_stock_price
	print("Sold Stock for $", heckler_stock_price)
