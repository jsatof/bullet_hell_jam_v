extends Node2D

var bullet = preload("res://Scenes/Bullet.tscn")
@onready var timer = $ShotTimer
var pool
var spawner1: Node2D = Node2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pool = get_parent().get_node("BulletPool")
	fire_pattern1()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shot_timer_timeout():
	# fire_pattern1()
	pass

func fire_pattern1():
	print("Fire pattern1")
	while true:
		rotation_degrees += 10
		for i in range(2):
			var b = pool.bullet()
			b.set_color(Color("CYAN"))
			b.transform = spawner1.transform
			b.rotation = rotation
			b.rotation_degrees += i * 180
			b.velocity = 200.0
			b.lifetime = 2
		await get_tree().create_timer(.1).timeout
