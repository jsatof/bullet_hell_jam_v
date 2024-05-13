extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
var angle = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShotTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += 2 * delta
	angle = fmod(angle, 360.0)
	rotate(deg_to_rad(angle))


func _on_shot_timer_timeout():
	var new_bullet = bullet.instantiate()
	new_bullet.lifetime = 2.0
	new_bullet.velocity = 200.0
	new_bullet.position = Vector2(self.position.y, self.position.y)
	new_bullet.rotation = global_rotation
	get_tree().root.add_child(new_bullet)

