extends Control

@onready var global := get_node("/root/GlobalState")
@onready var money_value := $MoneyValueLabel
@onready var accuracy_value := $AccuracyValueLabel
@onready var shares_owned_value := $SharesOwnedValueLabel
@onready var shop_gun_name := $EquippedGunNameLabel
@onready var equipped_gun_value := $EquippedGunValueLabel
@onready var trades_left_value := $TradesLeftValueLabel
@onready var ammo_bar := $'AmmoBar/FrontColorRect'
@onready var health_sprites = $'HealthSprites'

var ammo_max_size: float

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("buy_share"):
		on_buy_share_pressed()
	if event.is_action_pressed("sell_share"):
		on_sell_share_pressed()
	if event.is_action_pressed("buy_gun"):
		on_buy_gun_pressed()
	trades_left_value.text = "%d" % global.trades_remaining

func _ready() -> void:
	global.money_added.connect(update_money_label)
	money_value.text = "$%.2f" % global.money
	money_value.add_theme_color_override("font_color", Color.WEB_GREEN)
	accuracy_value.text = "%.2f%%" % global.get_accuracy()

	global.weapon_equipped.connect(update_ammo_bar)
	global.weapon_fired.connect(update_ammo_bar)
	ammo_max_size = ammo_bar.size.x

	global.player_damaged.connect(update_health_sprites)

	update_ammo_bar()
	update_health_sprites()

func update_money_label() -> void:
	money_value.text = "$%.2f" % global.money
	var money_label_color := Color.WEB_GREEN if global.money >= 0 else Color.DARK_RED
	money_value.add_theme_color_override("font_color", money_label_color)

func update_stock_owned_label() -> void:
	shares_owned_value.text = "%d" % global.heckler_shares_owned
	update_money_label()

func update_equipped_gun_label() -> void:
	equipped_gun_value.text = global.current_weapon["name"]

func on_buy_share_pressed() -> void:
	if global.buy_heckler_stock():
		update_stock_owned_label()
	# TODO: maybe play an animation when funds are insufficient

func on_sell_share_pressed() -> void:
	if global.sell_heckler_stock():
		update_stock_owned_label()
		trades_left_value.text = "%d" % global.trades_remaining
	# TODO: maybe play an animation when 0 stocks to sell

func on_buy_gun_pressed() -> void:
	if global.buy_and_equip_gun_from_shop():
		update_money_label()
		update_equipped_gun_label()
		trades_left_value.text = "%d" % global.trades_remaining
	# TODO: maybe play an animation when funds are insufficient

func update_ammo_bar() -> void:
	ammo_bar.size.x = ammo_max_size * global.get_ammo_percent()

func update_health_sprites() -> void:
	for i in range(0, global.max_lives - global.lives):
		health_sprites.get_child(global.max_lives - i-1).modulate = Color("BLACK")

	for i in range(0, global.lives):
		health_sprites.get_child(i).modulate = Color("WHITE")
