extends Control

@onready var money_value = $MoneyValueLabel
@onready var accuracy_value = $AccuracyValueLabel
@onready var shoot_button = $ShootBulletButton
@onready var boost_money = $BoostMoneyButton
@onready var subtract_money = $SubtractMoneyButton
@onready var global_state = get_node("/root/GlobalState")

func _ready():
	money_value.text = "$%.2f" % global_state.money
	money_value.add_theme_color_override("font_color", Color.WEB_GREEN)
	accuracy_value.text = "%.2f%%" % global_state.accuracy

	shoot_button.connect("button_down", on_shoot_button)
	boost_money.connect("button_down", on_boost_money)
	subtract_money.connect("button_down", on_subtract_money)

func on_shoot_button():
	global_state.bullet_count += 1
	if randi() % 2 == 0:
		global_state.hit_count += 1

	var new_acc: float = 100.0 * float(global_state.hit_count) / float(global_state.bullet_count)

	accuracy_value.text = "%.2f%%" % new_acc
	print("Bullet Count:", global_state.bullet_count)
	print("Hit Count:", global_state.hit_count)
	print("Acc:", new_acc)

func on_boost_money():
	global_state.money += 100.0
	if global_state.money >= 0:
		money_value.add_theme_color_override("font_color", Color.WEB_GREEN)
	money_value.text = "$%.2f" % global_state.money

func on_subtract_money():
	global_state.money -= 100.0
	if global_state.money < 0:
		money_value.add_theme_color_override("font_color", Color.DARK_RED)
	money_value.text = "$%.2f" % global_state.money

