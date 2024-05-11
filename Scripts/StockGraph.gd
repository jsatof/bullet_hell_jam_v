extends Control

@onready var panel = $PanelContainer
var random := RandomNumberGenerator.new()

var timer := Timer.new()

var stock_points : PackedVector2Array = [
	Vector2(0,0),
]

func _ready():
	seed(4444)
	random.randomize()
	timer.wait_time = 2.0
	timer.timeout.connect(on_timer_tick)

func _process(delta):

	queue_redraw()

func _draw():
	for p in stock_points:
		draw_circle(p, 10, Color.GREEN)

# every 2 seconds the stock prices will update
# so far only the last 10 points are saved,
# the oldest will be evicted when a new one comes in if full
func on_timer_tick():
	print("time passed")
	pass
