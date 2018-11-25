extends Area2D

func _ready():
	connect("area_entered", self, "on_area_entered")
	connect("area_exited", self, "on_area_exited")

func on_area_entered(object):
	if object.get_parent().name == 'CannonSpawner':
		object.get_parent().on_turret_entered()

func on_area_exited(object):
	if object.get_parent().name == 'CannonSpawner':
		object.get_parent().on_turret_exited()
