extends Area2D

var health: float = 100.0
var velocity: float = 100.0
var lifetime: float = 5.0
var movement_targets = []

var current_target: int = 0
var current_time: float = 0.0
# var move_tween: Tween

@onready var globals = get_node("/root/GlobalState")

func _ready():
	# move_tween = get_tree().create_tween().set_loops()
	current_time = 0.0
	current_target = 0
	move_to_targets()

func _process(delta):
	current_time += delta

	if current_time >= lifetime:
		remove_self()

func move_to_targets():
	for t in movement_targets:
		# Make a new tween each time because there was issues reusing one...sad
		var move_tween = get_tree().create_tween()
		move_tween.tween_property(self,
			"position",
			t.point,
			1).set_trans(t.trans)
		await move_tween.tween_interval(t.pause).finished
		move_tween.kill()

	remove_self()

func remove_self():
	print("dead")
	queue_free()
