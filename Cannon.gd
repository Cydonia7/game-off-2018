extends Node2D

export var fireInterval = 1.0
export var rotationInterval = 1.0
export var bulletSpeed = 40.0

var time = 0.0

func _process(delta):
	time += delta
	rotate(rotationInterval * delta)
	
	if time > fireInterval:
		time -= fireInterval
		fire()

func fire():
	var bullet = preload('res://Bullet.tscn').instance()
	var rotation = PI / 2 - $Spawn.get_global_transform_with_canvas().get_rotation()
	bullet.set_position($Spawn.get_global_transform_with_canvas().get_origin())
	bullet.set_rotation(rotation)
	bullet.velocity = Vector2(cos(rotation), sin(rotation)) * bulletSpeed
	get_parent().add_child(bullet)
