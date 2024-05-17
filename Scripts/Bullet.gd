extends Area2D

class_name Bullet

var velocity := 0.0
var amplitude := 1.0
var frequency := 1.0
# Not sure if we want this this yet
# var angular_rate := 0.0
var movement := Callable(self, "linear_move")
var lifetime := 10.0
var current_time := 0.0
var damage := 1.0
var target := Vector2(0.0, 0.0)


func _ready():
	current_time = 0.0

func _process(delta):
	movement.call(delta)
	current_time += delta

	if current_time >= lifetime:
		enable(false)

func set_color(color: Color):
	$OuterSprite.modulate = color


func enable(is_enabled: bool):
	current_time = 0
	set_process(is_enabled)
	set_physics_process(is_enabled)
	set_visible(is_enabled)
	get_child(0).disabled = !is_enabled


### Movement functions ###
func set_movement(move_type: String):
	match move_type:
		"linear":
			movement = Callable(self, "linear_move")
		"sin":
			movement = Callable(self, "sin_move")
		"cos":
			movement = Callable(self, "cos_move")

func linear_move(delta):
	position += transform.x * velocity * delta

func sin_move(delta):
	linear_move(delta)
	position += transform.y * amplitude * sin(current_time * frequency)

func cos_move(delta):
	linear_move(delta)
	position += transform.y * amplitude * cos(current_time * frequency)
