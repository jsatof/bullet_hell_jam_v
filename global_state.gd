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

func _ready():
	rng.seed = 42069
	set_new_heckler_stock_price()

func set_new_heckler_stock_price():
	last_heckler_stock_price = heckler_stock_price
	heckler_stock_price = rng.randf() * 50.0 + 40.0
	heckler_percent_diff = heckler_stock_price - last_heckler_stock_price / heckler_stock_price * 100.0
