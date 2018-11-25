extends Node2D

export var fireInterval = 1.0
export var rotationInterval = 1.0
export var bulletSpeed = 40.0

var time = 0.0

func _ready():
	connect("area_entered", self, "on_area_entered")
	connect("area_exited", self, "on_area_exited")

func on_area_entered(object):
	if object.get_parent().name == 'CannonSpawner':
		object.get_parent().on_turret_entered()

func on_area_exited(object):
	if object.get_parent().name == 'CannonSpawner':
		object.get_parent().on_turret_exited()

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
