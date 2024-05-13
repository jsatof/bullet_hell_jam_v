extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
@onready var timer = $ShotTimer
var spawner1: Node2D = Node2D.new()
var spawner2: Node2D = Node2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# spawner2.position.x += 50
	spawner2.rotation_degrees = 9


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shot_timer_timeout():
	fire_pattern1()

func fire_pattern1():
	print("Fire pattern1")
	for i in range(20):
		var b = bullet.instantiate()
		b.set_color(Color("YELLOW"))
		b.rotation_degrees += i * (360 / 20)
		b.velocity = 200.0
		b.lifetime = 2
		get_tree().root.add_child(b)


func _on_shot_timer_2_timeout():
	fire_pattern2()

func fire_pattern2():
	print("Fire pattern2")
	for i in range(20):
		var b = bullet.instantiate()
		b.set_color(Color("PINK"))
		b.transform = spawner2.transform
		b.rotation = spawner2.rotation
		b.rotation_degrees += i * (360 / 20)
		b.velocity = 200.0
		b.lifetime = 2
		get_tree().root.add_child(b)

func _on_timer_timeout():
	$ShotTimer2.start()
