extends Control

@onready var money_value := $MoneyValueLabel
@onready var accuracy_value := $AccuracyValueLabel
@onready var shares_owned_value := $SharesOwnedValueLabel
@onready var global := get_node("/root/GlobalState")

@onready var shoot_button := $TestButtons/ShootBulletButton
@onready var boost_money := $TestButtons/BoostMoneyButton
@onready var subtract_money := $TestButtons/SubtractMoneyButton
@onready var buy_share_button := $TestButtons/BuyShareButton
@onready var sell_share_button := $TestButtons/SellShareButton

func _ready():
	money_value.text = "$%.2f" % global.money
	money_value.add_theme_color_override("font_color", Color.WEB_GREEN)
	accuracy_value.text = "%.2f%%" % global.accuracy

	shoot_button.button_down.connect(on_shoot_button)
	boost_money.button_down.connect(on_boost_money)
	subtract_money.button_down.connect(on_subtract_money)
	buy_share_button.button_down.connect(on_buy_share_pressed)
	sell_share_button.button_down.connect(on_sell_share_pressed)

func on_shoot_button():
	global.bullet_count += 1
	if randi() % 2 == 0:
		global.hit_count += 1

	var new_acc: float = 100.0 * float(global.hit_count) / float(global.bullet_count)

	accuracy_value.text = "%.2f%%" % new_acc
	print("Bullet Count:", global.bullet_count)
	print("Hit Count:", global.hit_count)
	print("Acc:", new_acc)

func update_money():
	money_value.text = "$%.2f" % global.money
	if global.money >= 0:
		money_value.add_theme_color_override("font_color", Color.WEB_GREEN)
	else:
		money_value.add_theme_color_override("font_color", Color.DARK_RED)

func update_stock_owned():
	shares_owned_value.text = "%d" % global.heckler_shares_owned
	if global.heckler_shares_owned > 0:
		sell_share_button.disabled = false
	if global.heckler_shares_owned == 0:
		sell_share_button.disabled = true

	update_money()

	if global.heckler_stock_price > global.money:
		buy_share_button.disabled = true
	else:
		buy_share_button.disabled = false

func on_boost_money():
	global.money += 100.0
	update_money()

func on_subtract_money():
	global.money -= 100.0
	update_money()

func on_buy_share_pressed():
	global.buy_heckler_stock()
	update_stock_owned()

func on_sell_share_pressed():
	global.sell_heckler_stock()
	update_stock_owned()
