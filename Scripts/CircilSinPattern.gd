extends Node2D

var bullet = preload("res://Scenes/BulletSin.tscn")
@onready var timer = $ShotTimer
var spawner1: Node2D = Node2D.new()

var pool

func _ready():
	pool = get_parent().get_node("BulletPool")



func _on_shot_timer_timeout():
	for i in range(8):
		var b = pool.bullet()
		b.set_color(Color("PURPLE"))
		b.amplitude = 100.0
		b.frequency = 5.0
		spawner1.rotation_degrees += .1
		b.transform = spawner1.transform
		b.rotation_degrees += i * (360 / 8)
		b.position.x += 10
		b.velocity = 300.0
		b.lifetime = 5
