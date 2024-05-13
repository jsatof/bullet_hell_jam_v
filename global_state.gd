extends Node

@export_group("Game Properties")
@export var playspace = Vector2(200.0, 500.0)

var rng = RandomNumberGenerator.new()
var bullet_count = 0
var hit_count = 0
var accuracy = 100.0
var money: float = 1000.0

func _ready():
	seed(42069)
	rng.randomize()
