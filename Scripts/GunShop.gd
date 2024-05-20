extends Control

@onready var gun_name := $GunNameLabel
@onready var gun_price := $PurchaseValueLabel
@onready var timer := $Timer
@onready var timer_bar := $TimerBar/FrontColorRect
@onready var global := get_node("/root/GlobalState")

const max_duration := 8 # seconds until new weapon
var subbar_size: float # the amount of width to subtract on timer tick
var start_size: float
var weapon_for_sale: Dictionary

signal time_for_new_weapon

func _ready() -> void:
	assert(global)
	update_labels()

	subbar_size = float(timer_bar.size.x / max_duration)
	start_size = timer_bar.size.x

	timer.timeout.connect(on_timer_tick)
	time_for_new_weapon.connect(cycle_new_weapon)
	timer.start()

func set_weapon(weapon: Dictionary) -> void:
	timer_bar.size.x = start_size
	gun_name.text = weapon["name"] if weapon.has("name") else "NAMELESS ENTITY"
	gun_price.text = "$%.2f" % weapon["shopprice"] if weapon.has("shopprice") else "$69.69"
	global.current_purchasable_weapon = weapon
	timer.start()

func update_labels() -> void:
	gun_name.text = global.current_purchasable_weapon["name"]
	gun_price.text = "$%.2f" % global.current_purchasable_weapon["shopprice"]

func on_timer_tick() -> void:
	timer_bar.size.x -= subbar_size
	if timer_bar.size.x < 1:
		timer.stop()
		time_for_new_weapon.emit()

func cycle_new_weapon() -> void:
	set_weapon(global.get_random_weapon())
