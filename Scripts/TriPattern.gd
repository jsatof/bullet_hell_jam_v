extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
@onready var timer = $ShotTimer
var spawner1: Node2D = Node2D.new()

var calls = 0
var max_calls = 3

func _ready():
	pass


func _process(delta):
	pass


func _on_shot_timer_timeout():
	calls = 0
	$ShotTimer2.start()

func _on_shot_timer_2_timeout():
	print("Fire pattern1")
	var rot = -10
	for i in range(3):
		var b = bullet.instantiate()
		b.set_color(Color("PINK"))
		b.transform = spawner1.transform
		b.rotation = rotation
		b.rotation_degrees += rot
		b.velocity = 200.0
		b.lifetime = 2
		get_tree().root.add_child(b)

		rot += 10

	calls += 1
	if calls >= max_calls:
		$ShotTimer2.stop()
		$ShotTimer.start()
		calls = 0;
