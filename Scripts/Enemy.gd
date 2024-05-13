extends Area2D

var health: float = 100.0
var velocity: float = 100.0
var lifetime: float = 5.0

var current_time: float = 0.0

@onready var globals = get_node("/root/GlobalState")

func _ready():
	current_time = 0.0
	pass

func _process(delta):
	position += transform.y * velocity * delta
	current_time += delta
	if current_time >= lifetime:
		remove_self()

func remove_self():
	queue_free()
