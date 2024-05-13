extends Area2D

var velocity = 0.0
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
		queue_free()

func set_color(color: Color):
	$OuterSprite.modulate = color

func linear(vel):
	return vel

func accel(vel, acc):
	return vel * acc
