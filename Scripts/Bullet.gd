extends Area2D

class_name Bullet

var velocity := 0.0
var amplitude := 1.0
var frequency := 1.0
var acceleration := 1.0
var movement := Callable(self, "linear_move")
var lifetime := 4.0
var current_time := 0.0
# var damage := 1.0 #UNSUED


func _ready():
	current_time = 0
	set_process(false)
	set_physics_process(false)
	set_visible(false)
	$CollisionShape.disabled = true

func _process(delta):
	movement.call(delta)
	current_time += delta

	if current_time >= lifetime:
		enable(false)

func set_color(color: Color):
	$OuterSprite.modulate = color

# Do not use on bult initilization. Deffering action leads to long load time
func enable(is_enabled: bool):
	current_time = 0
	set_process(is_enabled)
	set_physics_process(is_enabled)
	set_visible(is_enabled)
	get_child(0).set_deferred("disabled", !is_enabled)


### Movement functions ###
func set_movement(move_type: String):
	print("Set movement")
	match move_type:
		"linear":
			movement = Callable(self, "linear_move")
		"sin":
			movement = Callable(self, "sin_move")
		"cos":
			movement = Callable(self, "cos_move")

func linear_move(delta):
	velocity *= acceleration
	position += transform.orthonormalized().x * velocity * delta

func sin_move(delta):
	linear_move(delta)
	position += transform.orthonormalized().y * amplitude * sin(current_time * frequency)

func cos_move(delta):
	linear_move(delta)
	position += transform.orthonormalized().y * amplitude * cos(current_time * frequency)
