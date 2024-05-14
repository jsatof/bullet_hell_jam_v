extends Area2D

var velocity = 10.0
var lifetime = 1.0
var current_time = 0.0
var target: Vector2 = Vector2(0.0, 0.0)

func _ready():
	current_time = 0.0

func _process(delta):
	position += transform.x * velocity * delta
	# position += transform.x * direction * 50 * delta
	current_time += delta

	if current_time >= lifetime:
		enable(false)

func set_color(color: Color):
	$OuterSprite.modulate = color

func linear(vel):
	return vel

func accel(vel, acc):
	return vel * acc

func enable(is_enabled: bool):
	set_process(is_enabled)
	set_physics_process(is_enabled)
	set_visible(is_enabled)
	get_child(0).disabled = !is_enabled

