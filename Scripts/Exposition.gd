extends Control

@onready var audio_manager := get_node("/root/AudioManager")
@onready var global := get_node("/root/GlobalState")

@onready var collect_label := $CollectLabel
@onready var buy_weapons_label := $BuyWeaponsLabel
@onready var make_investments_label := $MakeInvestmentsLabel
@onready var payback_label := $PaybackLabel
@onready var continue_label := $ContinueLabel
@onready var timer := $Timer

var label_list: Array
var ready_to_continue := false

func _ready() -> void:
	audio_manager.add_soundtrack_lpf()

	# these must be in order
	# and set to NOT visible in the scene
	label_list = [
		collect_label,
		buy_weapons_label,
		make_investments_label,
		payback_label,
		continue_label,
	]

	timer.timeout.connect(on_timer_timeout)
	timer.wait_time = 2
	timer.start()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("buy_gun"):
		audio_manager.remove_soundtrack_lpf()
		global.start_new_game()

func on_timer_timeout() -> void:
	if len(label_list) > 0:
		label_list.front().set_visible(true)
		label_list = label_list.slice(1, len(label_list))
	else:
		ready_to_continue = true
		timer.stop()
