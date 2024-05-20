extends Control

@onready var global := get_node("/root/GlobalState")
@onready var main_menu_button := $GotoMainMenuButton
@onready var win_lose_label := $WinLoseLabel
@onready var caption_label := $CaptionLabel
@onready var timer := $Timer

@onready var audio_manager := get_node("/root/AudioManager")
@onready var soundtrack := AudioStreamOggVorbis.load_from_file("res://Resources/Audio/Music/Reonidas.ogg")

var label_stack := []
var accuracy_bonus := 0.0
var portfolio_value := 0.0

signal finished

func _ready() -> void:
	accuracy_bonus = global.get_accuracy() * 5.0
	portfolio_value = global.heckler_stock_price * global.heckler_shares_owned
	global.add_money(accuracy_bonus)

	main_menu_button.button_down.connect(on_main_menu_button_pressed)
	timer.timeout.connect(on_timer_tick)
	finished.connect(on_finished)

	if !(global.end_screen_state == global.EndScreenState.YOU_DIED):
		audio_manager.set_soundtrack(soundtrack)
		audio_manager.play_soundtrack()

	match global.end_screen_state:
		global.EndScreenState.LEVEL_CLEAR:
			win_lose_label.text = "LEVEL CLEAR"
			caption_label.text = "Mission cleared. Onwards to the next. We got money to make."
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
	const x_offset := 145
	const x_indent := 8
	var x_start := size.x / 4
	var current_pos :=  Vector2(x_start, size.y / 3)

	var next_label := create_new_label(current_pos, Color.WHITE, "Accuracy:")
	label_stack.push_back(next_label)

	current_pos = Vector2(current_pos.x + next_label.size.x + x_offset, current_pos.y)
	next_label = create_new_label(current_pos, Color.WHITE, "%.2f%%" % global.get_accuracy())
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start + 1.5 * x_indent, current_pos.y + next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Accuracy Bonus:")
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start + x_offset, current_pos.y)
	next_label = create_new_label(current_pos, Color.WEB_GREEN, "$%.2f" % accuracy_bonus)
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start, current_pos.y + 1.5 * next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Portfolio Value:")
	label_stack.push_back(next_label)

	current_pos = Vector2(current_pos.x + next_label.size.x + x_offset, current_pos.y)
	var net_gains_color := Color.WEB_GREEN if portfolio_value >= 0.0 else Color.DARK_RED
	next_label = create_new_label(current_pos, net_gains_color, "$%.2f" % portfolio_value)
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start, current_pos.y + 1.5 * next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Your Money:")
	label_stack.push_back(next_label)

	current_pos = Vector2(current_pos.x + next_label.size.x + x_offset, current_pos.y)
	var total_money_color := Color.WEB_GREEN if global.money > 0.0 else Color.DARK_RED
	next_label = create_new_label(current_pos, total_money_color, "$%.2f" % global.money)
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start, current_pos.y + 1.5 * next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Debt Remaining:")
	label_stack.push_back(next_label)

	current_pos = Vector2(current_pos.x + next_label.size.x + x_offset, current_pos.y)
	next_label = create_new_label(current_pos, Color.DARK_RED, "$%.2f" % float(10_000_000.0 - global.money))
	label_stack.push_back(next_label)

	current_pos = Vector2(x_start, current_pos.y + 1.5 * next_label.size.y)
	next_label = create_new_label(current_pos, Color.WHITE, "Press 'F' to continue")
	next_label.position.x = size.x / 3 - next_label.size.x # to re-center the "continue" label
	label_stack.push_back(next_label)

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("buy_gun")):
		match global.end_screen_state:
			global.EndScreenState.LEVEL_CLEAR:
				global.load_next_level()
			_:
				global.goto_main_menu()


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
