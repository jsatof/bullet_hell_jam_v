extends Area2D

var health: float = 100.0
var velocity: float = 100.0
var lifetime: float = 5.0
var movement_targets = []

var current_target: int = 0
var current_time: float = 0.0

@onready var globals = get_node("/root/GlobalState")

func _ready():
	current_time = 0.0
	current_target = 0
	move_to_targets()

func _process(delta):
	current_time += delta

	if current_time >= lifetime:
		remove_self()

# Due to the need to await the pause I had to go with this solution
# The more elegent for each loop was not viable to my knowledge
func move_to_targets():
	var t = movement_targets[current_target]
	var move_tween = get_tree().create_tween()
	move_tween.tween_property(self,
		"position",
		t.point,
		1).set_trans(t.trans)
	move_tween.tween_callback(next_position.bind(t.pause))

func next_position(time: float):
	await get_tree().create_timer(time).timeout
	current_target += 1
	if current_target >= movement_targets.size():
		remove_self()
	else:
		move_to_targets()

func remove_self():
	print("dead")
	queue_free()
