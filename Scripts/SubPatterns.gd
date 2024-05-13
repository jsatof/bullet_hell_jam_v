extends Node

var bullet = preload("res://Scenes/BulletSin.tscn")

func circular(quantity: int, spawner: Transform2D, color: Color):
	for i in range(quantity):
		var b = bullet.instantiate()
		b.set_color(color)
		b.amplitude = 100.0
		b.frequency = 5.0
		b.transform = spawner
		b.rotation_degrees += i * (360 / quantity)
		b.position.x += 10
		b.velocity = 300.0
		b.lifetime = 5
		get_tree().root.add_child(b)
