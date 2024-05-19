extends Control

@onready var gun_name := $GunNameLabel
@onready var gun_price := $PurchaseValueLabel
@onready var gun_bullet_cost := $PricePerShotValueLabel
@onready var global := get_node("/root/GlobalState")

func _ready() -> void:
	assert(global)
	update_labels()

func update_labels() -> void:
	gun_name.text = global.current_purchasable_weapon["name"]
	gun_price.text = "$%.2f" % global.current_purchasable_weapon["shopprice"]
