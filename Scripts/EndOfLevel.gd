extends Control

@onready var global := get_node("/root/GlobalState")
@onready var main_menu_button := $GotoMainMenuButton
@onready var win_lose_label := $WinLoseLabel
@onready var caption_label := $CaptionLabel
@onready var variable_labels_group := $VariableLabelsGroup
@onready var timer := $Timer

var label_stack := []
var accuracy_bonus := 0.0
var net_gains := 420.0

signal finished

func _ready() -> void:
	var bill_subtotal: float = float(global.bullet_counter["pea_shooter"]) * global.pea_shooter_gun["bulletcost"] + float(global.bullet_counter["bigger_gun"]) * global.bigger_gun["bulletcost"]
	accuracy_bonus = global.get_accuracy() * 5.0
	net_gains = accuracy_bonus - bill_subtotal
	global.add_money(net_gains)
	print("Net Gains: %.2f" % net_gains)
	print("Bill Subtotal: $%.2f" % bill_subtotal)

	main_menu_button.button_down.connect(on_main_menu_button_pressed)
	timer.timeout.connect(on_timer_tick)
	finished.connect(on_finished)

	match global.end_screen_state:
		global.EndScreenState.VICTORY:
			win_lose_label.text = "YOU WIN"
			caption_label.text = "All the debt owed was paid. Contract passed."
		global.EndScreenState.DEFEAT:
			win_lose_label.text = "YOU LOSE"
			caption_label.text = "The owed debt was unable to be repaid. Contract Failed."
		global.EndScreenState.YOU_DIED:
			win_lose_label.text = "YOU DIED"
			caption_label.text = "You were killed in action. Now your relatives inherit your debt."

	init_label_positions()

	timer.wait_time = 0.5
	timer.start()

# programatically create the labels for the statistics and put them on a stack
func init_label_positions() -> void:
	const x_offset := 200
	const x_indent := 16
	var x_start := size.x / 3 + 66
	var current_pos :=  Vector2(x_start, size.y / 3)
	var next_label: Label = create_new_label(current_pos, Color.WHITE, "Bullets Fired:")
	label_stack.push_back(next_label)

	current_pos = Vector2(current_pos.x + next_label.size.x + x_offset, current_pos.y)
	next_label = create_new_label(current_pos, Color.WHITE, "%d" % global.bullet_counter["total"])
	label_stack.push_back(next_label)

	if global.bullet_counter["pea_shooter"] > 0:
		current_pos = Vector2(x_start + x_indent, current_pos.y + next_label.size.y)
		next_label = create_new_label(current_pos, Color.WHITE, "Pea Shooter:")
		label_stack.push_back(next_label)

		current_pos = Vector2(x_start + x_offset, current_pos.y)
		next_label = create_new_label(current_pos, Color.WHITE, "%d" % global.bullet_counter["pea_shooter"])
		label_stack.push_back(next_label)

		current_pos = Vector2(x_start + 2 * x_indent, current_pos.y + next_label.size.y)
		next_label = create_new_label(current_pos, Color.WHITE, "%d x $%.2f:" % [global.bullet_counter["pea_shooter"], global.pea_shooter_gun["bulletcost"]])
		label_stack.push_back(next_label)

		current_pos = Vector2(x_start + x_offset, current_pos.y)
		next_label = create_new_label(current_pos, Color.DARK_RED, "$%.2f" % float(-global.bullet_counter["pea_shooter"] * global.pea_shooter_gun["bulletcost"]))
		label_stack.push_back(next_label)

	if global.bullet_counter["bigger_gun"] > 0:
		current_pos = Vector2(x_start + x_indent, current_pos.y + next_label.size.y)
		next_label = create_new_label(current_pos, Color.WHITE, "Bigger Gun:")
		label_stack.push_back(next_label)

		current_pos = Vector2(x_start + x_offset, current_pos.y)
		next_label = create_new_label(current_pos, Color.WHITE, "%d" % global.bullet_counter["bigger_gun"])
		label_stack.push_back(next_label)

		current_pos = Vector2(x_start + 2 * x_indent, current_pos.y + next_label.size.y)
		next_label = create_new_label(current_pos, Color.WHITE, "%d x $%.2f:" % [global.bullet_counter["bigger_gun"], global.bigger_gun["bulletcost"]])
		label_stack.push_back(next_label)

		current_pos = Vector2(x_start + x_offset, current_pos.y)
		next_label = create_new_label(current_pos, Color.DARK_RED, "$%.2f" % float(-global.bullet_counter["bigger_gun"] * global.bigger_gun["bulletcost"]))
		label_stack.push_back(next_label)

	current_pos = Vector2(x_start, current_pos.y + 2 * next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Accuracy:")
	label_stack.push_back(next_label)

	current_pos = Vector2(current_pos.x + next_label.size.x + x_offset, current_pos.y)
	next_label = create_new_label(current_pos, Color.WHITE, "%.2f%%" % global.get_accuracy())
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start + 2 * x_indent, current_pos.y + next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Accuracy Bonus:")
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start + x_offset, current_pos.y)
	next_label = create_new_label(current_pos, Color.WEB_GREEN, "$%.2f" % accuracy_bonus)
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start, current_pos.y + 2 * next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Net Gains:")
	label_stack.push_back(next_label)

	current_pos = Vector2(current_pos.x + next_label.size.x + x_offset, current_pos.y)
	var net_gains_color := Color.WEB_GREEN if net_gains > 0.0 else Color.DARK_RED
	next_label = create_new_label(current_pos, net_gains_color, "$%.2f" % net_gains)
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start, current_pos.y + 2 * next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Your Money:")
	label_stack.push_back(next_label)

	current_pos = Vector2(current_pos.x + next_label.size.x + x_offset, current_pos.y)
	var total_money_color := Color.WEB_GREEN if global.money > 0.0 else Color.DARK_RED
	next_label = create_new_label(current_pos, total_money_color, "$%.2f" % global.money)
	label_stack.push_back(next_label)

# helper to generate label nodes
func create_new_label(pos: Vector2, color: Color, text: String) -> Label:
	var new_label := Label.new()
	new_label.add_theme_color_override("font_color", color)
	new_label.position = pos
	new_label.text = text
	#print("New Label\n\tPos: [%d, %d]\n\tSize: [%d, %d]\n\tText: %s" % [new_label.position.x, new_label.position.y, new_label.size.x, new_label.size.y, new_label.text])
	return new_label

# every timer tick, pop the label stack and display that label
func on_timer_tick() -> void:
	if len(label_stack) < 1:
		finished.emit()
		return
	var front: Label = label_stack.front()
	label_stack = label_stack.slice(1, len(label_stack))
	add_child(front)

func on_main_menu_button_pressed() -> void:
	global.goto_main_menu(self)

func on_finished() -> void:
	timer.stop()
