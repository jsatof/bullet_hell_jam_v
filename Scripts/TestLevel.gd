extends Node2D

var Enemy = preload("res://Scenes/Enemy.tscn")

var group_timer: float = 0
var current_group: int = -1
var groups = []


# Called when the node enters the scene tree for the first time.
func _ready():
	group_timer = 0
	current_group = -1
	# groups[0] = Group.new(0.0, 0.5, [])
	groups.append({
		"delay": 0.0, "time": 1.0, "enemies": [
			{"health": 100, "speed": 300, "position": Vector2(0.0, -400.0), "lifetime": 5},
			{"health": 100, "speed": 300, "position": Vector2(100.0, -430.0), "lifetime": 5},
			{"health": 100, "speed": 300, "position": Vector2(-80.0, -470.0),  "lifetime": 5},
		]
	})
	call_next_group()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	group_timer += delta

func call_next_group():
	current_group += 1
	if current_group >= groups.size():
		pass

	for i in groups[current_group]["enemies"]:
		var e = Enemy.instantiate()
		e.health = i["health"]
		e.velocity = i["speed"]
		e.lifetime = i["lifetime"]
		e.position = i["position"]

		add_child(e)
