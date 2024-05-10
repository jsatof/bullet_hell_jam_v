extends Area2D

var move_speed:float = 200.0
var input = Vector2(0.0, 0.0)
var health = 100
var movement_range = Vector2(200.0, 500.0)

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	pass

func _process(delta):
	input = Input.get_vector("move_left", "move_right", "move_up", "move_down")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = input * delta * move_speed
	position += velocity
	position = position.clamp(-movement_range, movement_range)


func _on_area_entered(area):
	hit.emit()
	health -= 10
	print("Health: ", health)
