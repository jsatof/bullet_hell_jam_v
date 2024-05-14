extends Area2D

var health: float = 100.0
var velocity: float = 100.0
var lifetime: float = 5.0
var movement_targets = []

var current_target: int = 0
var current_time: float = 0.0

@onready var globals = get_node("/root/GlobalState")
var bullet = preload("res://Scenes/Bullet.tscn")

func _ready():
	current_time = 0.0
	current_target = 0
	move_to_targets()
	fire_pattern()

func _process(delta):
	current_time += delta

	if current_time >= lifetime:
		remove_self()

func move_to_targets():
	var move_tween = get_tree().create_tween()
	for t in movement_targets:
		move_tween.chain().tween_property(self,
			"position",
			t.point,
			t.time).set_trans(t.trans)
		move_tween.tween_interval(t.pause).finished

	await move_tween.finished
	remove_self()

func fire_pattern():
	for i in range(0, 5):
		for j in range(3):
			var b = bullet.instantiate()
			b.set_color(Color("RED"))
			b.position = position
			b.position.x += -100 + (j * 100)
			b.velocity = 400.0
			b.lifetime = 20
			b.look_at(Vector2(0.0, 400.0))
			get_tree().root.add_child(b)
		await get_tree().create_timer(.7).timeout

func remove_self():
	print("dead")
	queue_free()
