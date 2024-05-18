extends Control

@onready var global := get_node("/root/GlobalState")
@onready var money_value := $MoneyValueLabel
@onready var accuracy_value := $AccuracyValueLabel
@onready var shares_owned_value := $SharesOwnedValueLabel
@onready var shop_gun_name := $EquippedGunNameLabel
@onready var equipped_gun_value := $EquippedGunValueLabel

@onready var win_button := $TestButtons/WinButton

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("buy_share"):
		on_buy_share_pressed()
	if event.is_action_pressed("sell_share"):
		on_sell_share_pressed()
	if event.is_action_pressed("buy_gun"):
		on_buy_gun_pressed()

func _ready() -> void:
	global.money_added.connect(update_money_label)
	money_value.text = "$%.2f" % global.money
	money_value.add_theme_color_override("font_color", Color.WEB_GREEN)
	accuracy_value.text = "%.2f%%" % global.get_accuracy()
	win_button.button_down.connect(on_win_button_pressed)
	global.player_died.connect(on_player_died)

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
	# TODO: maybe play an animation when 0 stocks to sell

func on_buy_gun_pressed() -> void:
	if global.buy_and_equip_gun_from_shop():
		update_money_label()
		update_equipped_gun_label()
	# TODO: maybe play an animation when funds are insufficient

func on_win_button_pressed() -> void:
	global.end_screen_state = global.EndScreenState.VICTORY
	global.goto_end_screen(get_parent())

func on_player_died():
	global.end_screen_state = global.EndScreenState.YOU_DIED
	global.goto_end_screen(get_parent())
