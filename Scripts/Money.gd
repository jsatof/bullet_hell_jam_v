extends Area2D

@onready var globals = get_node("/root/GlobalState")
@onready var player = get_tree().get_first_node_in_group("Player")
var collected := false
var t := 0.0

signal money_collected

func _ready() -> void:
	t = 0.0
	collected = false
	set_process(false)
	set_physics_process(false)
	set_visible(false)
	$CollisionShape.disabled = true

func _process(delta: float) -> void:
	position += transform.orthonormalized().y * globals.money_speed * delta

	if collected:
		t += delta * 0.6
		position = position.lerp(player.position, t)
		if t >= 0.2:
			money_collected.emit()
			globals.collect_scrap()
			enable(false)

	if global_position.y >= globals.playspace.y + 20:
		enable(false)

func collect() -> void:
	collected = true

func enable(is_enabled: bool) -> void:
	t = 0.0
	collected = !is_enabled
	set_process(is_enabled)
	set_physics_process(is_enabled)
	set_visible(is_enabled)
	get_child(0).set_deferred("disabled", !is_enabled)
