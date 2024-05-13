extends Node2D

@onready var global = get_node("/root/GlobalState")
@onready var price_label = get_parent().get_node("StockPriceLabel")
@onready var price_diff_label = get_parent().get_node("StockDiffLabel")
@onready var color_rect = get_parent().get_node("GraphBGColorRect")
@onready var timer := get_parent().get_node("Timer")

var stock_points: PackedFloat32Array

# draw region is 300x300
const y_start_pos := 350.0
const point_size := 3
const scaling := 3.5

func _ready():
	assert(price_label)
	assert(price_diff_label)
	assert(color_rect)
	assert(timer)

func _draw():
	for i in range(1, len(stock_points)):
		var start := Vector2(point_size + (i - 1) * color_rect.size.x / 8, stock_points[i - 1])
		var current := Vector2(point_size + i * color_rect.size.x / 8, stock_points[i])
		draw_line(start, current, Color.WEB_GREEN, 1, true)
	# draw circle at last point
	if len(stock_points) > 0:
		var last_index := len(stock_points) - 1
		draw_circle(Vector2(point_size + last_index * color_rect.size.x / 8, stock_points[last_index]), point_size, Color.WEB_GREEN)

# every second the stock prices will update
# so far only the last 10 points are saved,
# the oldest will be evicted when a new one comes in if full
func _on_timer_timeout():
	print("Current Stock Price: $%.2f" % global.heckler_stock_price)
	var current_price: float = global.heckler_stock_price
	var percent_diff: float = global.heckler_percent_diff

	price_label.text = "$%.2f" % current_price

	if percent_diff < 0.0:
		price_diff_label.add_theme_color_override("font_color", Color.DARK_RED)
	else:
		price_diff_label.add_theme_color_override("font_color", Color.WEB_GREEN)
	price_diff_label.text = "%.2f%%" % percent_diff

	var new_price_point: float = y_start_pos - scaling * current_price
	stock_points.push_back(new_price_point)

	# Test code for interacting with stock market
	if current_price > 70.0:
		print("Current Stock Price: ", current_price)
		timer.stop()

	if len(stock_points) >= 10:
		stock_points = stock_points.slice(1, 10)

	global.set_new_heckler_stock_price()
	queue_redraw()





