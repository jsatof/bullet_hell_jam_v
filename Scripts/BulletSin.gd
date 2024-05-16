extends Area2D

var velocity: float = 0.0
var lifetime: float = 1.0
var current_time: float = 0.0
var target: Transform2D

var amplitude: float = 1.0
var frequency: float = 1.0
var direction: Vector2 = Vector2(0.0, 1.0)

func _ready():
	current_time = 0.0


func _process(delta):
	# direction = direction.rotated(angle)
	# direction *= (amplitude * sin(frequency * current_time))
	# var fuckgd = (10 if test2 < 100 else -10)
	# direction = direction.rotated(deg_to_rad(fuckgd))
	# direction = direction.normalized()
	# print(direction)
	position += transform.y * velocity * delta
	position += transform.x * (amplitude * sin(frequency * current_time)) * delta
	position += transform.x * (amplitude * sin(frequency * current_time))
	current_time += delta

	if current_time >= lifetime:
		queue_free()

func set_color(color: Color):
	$OuterSprite.modulate = color

func linear(vel):
	return vel

func accel(vel, acc):
	return vel * acc
