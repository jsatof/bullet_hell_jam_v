extends Node2D

var bullet = preload("res://Scenes/BulletSin.tscn")
@onready var timer = $ShotTimer
var spawner1: Node2D = Node2D.new()

func _ready():
	pass


func _process(delta):
	pass


func _on_shot_timer_timeout():
	for i in range(4):
		var b = bullet.instantiate()
		b.set_color(Color("PURPLE"))
		b.amplitude = 100.0
		b.frequency = 5.0
		b.transform = spawner1.transform
		b.rotation_degrees += i * (360 / 4)
		b.position.x += 10
		b.velocity = 300.0
		b.lifetime = 5
		get_tree().root.add_child(b)
