extends Camera2D

func _process():
	self.position += Vector2(rand_range(-10, 10), rand_range(-10, 10))
