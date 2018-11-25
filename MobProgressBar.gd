extends CanvasItem

var progress_max = 1;
var progress_value = 1;
var rect_size = Vector2(10, 100)
var rect_margin = 5
var green = Color(16.0 / 255.0, 165.0 / 255.0, 36.0 / 255.0)
var red = Color(178.0 / 255.0, 8.0 / 255.0, 8.0 / 255.0)

func _draw():
	var full_width = progress_max * rect_size.x + (progress_max - 1) * rect_margin
	
	for i in range(progress_max):
		draw_rect(Rect2(Vector2((rect_size.x + rect_margin) * i - full_width / 2, 0), rect_size), green if i < progress_value else red)

func set_max(maxi):
	progress_max = maxi
	update()

func get_max():
	return progress_max

func set_value(value):
	progress_value = value
	update()

func get_value():
	return progress_value
