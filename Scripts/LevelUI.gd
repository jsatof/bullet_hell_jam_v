extends Control

@onready var global := get_node("/root/GlobalState")
@onready var money_value := $MoneyValueLabel
@onready var accuracy_value := $AccuracyValueLabel
@onready var shares_owned_value := $SharesOwnedValueLabel
@onready var shop_gun_name := $GunNameLabel
@onready var shop_gun_purchase_value := $PurchaseValueLabel
@onready var shop_gun_price_per_shot := $PricePerShotValueLabel
@onready var gun_image_region := $GunImageRegion
@onready var equipped_gun_value := $EquippedGunValueLabel

@onready var shoot_button := $TestButtons/ShootBulletButton
@onready var boost_money := $TestButtons/BoostMoneyButton
@onready var subtract_money := $TestButtons/SubtractMoneyButton
@onready var buy_share_button := $TestButtons/BuyShareButton
@onready var sell_share_button := $TestButtons/SellShareButton
@onready var buy_gun_button := $TestButtons/BuyGunButton

func _ready() -> void:
	money_value.text = "$%.2f" % global.money
	money_value.add_theme_color_override("font_color", Color.WEB_GREEN)
	accuracy_value.text = "%.2f%%" % global.accuracy

	shoot_button.button_down.connect(on_shoot_button)
	boost_money.button_down.connect(global.add_money, 100.0)
	subtract_money.button_down.connect(global.add_money, -100.0)
	buy_share_button.button_down.connect(on_buy_share_pressed)
	sell_share_button.button_down.connect(on_sell_share_pressed)
	buy_gun_button.button_down.connect(on_buy_gun_pressed)

#  TODO: proper detection on a bullet collision is a priority
func on_shoot_button() -> void:
	global.simulate_bullet_fired()
	var acc: float = global.get_accuracy()

	accuracy_value.text = "%.2f%%" % acc
	print("Bullet Count:", global.total_bullet_count)
	print("Hit Count:", global.hit_count)
	print("Acc:", acc)

func update_money_label() -> void:
	money_value.text = "$%.2f" % global.money
	var money_label_color := Color.WEB_GREEN if global.money >= 0 else Color.DARK_RED
	money_value.add_theme_color_override("font_color", money_label_color)

func update_stock_owned_label() -> void:
	shares_owned_value.text = "%d" % global.heckler_shares_owned
	sell_share_button.disabled = global.heckler_shares_owned == 0
	buy_share_button.disabled = global.heckler_stock_price > global.money
	update_money_label()

func update_equipped_gun_label() -> void:
	equipped_gun_value.text = global.current_equipped_gun["name"]
	buy_gun_button.disabled = global.money < global.current_purchasable_gun["shopprice"]

func on_buy_share_pressed() -> void:
	global.buy_heckler_stock()
	update_stock_owned_label()

func on_sell_share_pressed() -> void:
	global.sell_heckler_stock()
	update_stock_owned_label()

func on_buy_gun_pressed() -> void:
	global.buy_and_equip_gun_from_shop()
	update_money_label()
	update_equipped_gun_label()

