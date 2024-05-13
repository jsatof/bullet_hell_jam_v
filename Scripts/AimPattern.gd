extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
@onready var timer = $ShotTimer
var spawner1: Node2D = Node2D.new()

func _ready():
	pass


func _process(delta):
	pass


func _on_shot_timer_timeout():
	for i in range(3):
		var b = bullet.instantiate()
		b.set_color(Color("RED"))
		b.transform = spawner1.transform
		b.position.x += -100 + (i * 100)
		b.velocity = 300.0
		b.lifetime = 5
		b.look_at(Vector2(0.0, 400.0))
		get_tree().root.add_child(b)
