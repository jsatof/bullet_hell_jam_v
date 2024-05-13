extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
@onready var timer = $ShotTimer
var spawner1: Node2D = Node2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shot_timer_timeout():
	fire_pattern1()

func fire_pattern1():
	print("Fire pattern1")
	rotation_degrees += 10
	for i in range(2):
		var b = bullet.instantiate()
		b.set_color(Color("CYAN"))
		b.transform = spawner1.transform
		b.rotation = rotation
		b.rotation_degrees += i * 180
		b.velocity = 200.0
		b.lifetime = 2
		get_tree().root.add_child(b)
