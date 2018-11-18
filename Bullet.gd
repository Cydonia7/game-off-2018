extends Node2D

export var velocity = Vector2(0, 0);
export var life = 1.6

var time = 0.0

func _enter_tree():
	$BulletArea.connect("area_entered", self, "hit")

func _process(delta):
	time += delta
	
	set_position(get_position() + velocity * delta)
	
	if time > life:
		queue_free()

func hit(object):
	if object.name == 'MobArea':
		queue_free()
