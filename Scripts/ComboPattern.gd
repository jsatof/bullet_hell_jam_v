extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
var spawner1: Transform2D = transform

var timer: Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(20):
		var b = bullet.instantiate()
		b.set_color(Color("PINK"))
		b.transform = spawner1
		b.rotation_degrees += i * (360 / 20)
		b.velocity = 200.0
		b.lifetime = 2
		get_tree().root.add_child(b)
	pass


