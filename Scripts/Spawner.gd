extends Node2D

@export var bullet: PackedScene
var range:Vector2 = Vector2(-300.0, 300.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShotTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_shot_timer_timeout():
	var x_loc = randf_range(range.x, range.y)
	var new_bullet = bullet.instantiate()
	new_bullet.position = Vector2(x_loc, self.position.y)
	add_child(new_bullet)
