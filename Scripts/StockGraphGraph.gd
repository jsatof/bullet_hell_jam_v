extends Node2D

@onready var global := get_node("/root/GlobalState")
@onready var price_label := get_parent().get_node("StockPriceLabel")
@onready var price_diff_label := get_parent().get_node("StockDiffLabel")
@onready var color_rect := get_parent().get_node("GraphBGColorRect")
@onready var timer := get_parent().get_node("Timer")

var stock_points: PackedFloat32Array
const max_stock_points_size := 10
const point_size := 4

func _ready() -> void:
	assert(price_label)
	assert(price_diff_label)
	assert(color_rect)
	assert(timer)

func _draw() -> void:
	for i in range(1, len(stock_points)):
		var start: Vector2 = screen_coord_from_stock_points(i - 1)
		var current: Vector2 = screen_coord_from_stock_points(i)
		draw_line(start, current, Color.WEB_GREEN, 2, true)
	# draw circle at last point
	if len(stock_points) > 0:
		var last_index := len(stock_points) - 1
		draw_circle(screen_coord_from_stock_points(last_index), point_size, Color.WEB_GREEN)

# every second the stock prices will update
# so far only the last 10 points are saved,
# the oldest will be evicted when a new one comes in if full
func _on_timer_timeout() -> void:
	global.set_new_heckler_stock_price()
	var current_price: float = global.heckler_stock_price
	var percent_diff: float = global.heckler_percent_diff

	price_label.text = "$%.2f" % current_price
	var label_color := Color.DARK_RED if percent_diff < 0.0 else Color.WEB_GREEN
	price_diff_label.add_theme_color_override("font_color", label_color)
	price_diff_label.text = "%.2f%%" % percent_diff

	var new_price_point: float = color_rect.size.y - current_price
	stock_points.push_back(new_price_point)

	if len(stock_points) >= max_stock_points_size:
		stock_points = stock_points.slice(1, max_stock_points_size)

	queue_redraw()

func screen_coord_from_stock_points(index: int) -> Vector2:
	# This condition should never occur, but just in case
	if index < 0 || index >= len(stock_points):
		return Vector2(-1000, -1000) # will lead to draw dramatically wild line
	return Vector2(index * color_rect.size.x / 8, stock_points[index])

