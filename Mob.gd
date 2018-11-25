extends Node2D 

export var mobName = 'libeluliste'

func _ready():
	$Sprite.texture = load("res://images/mobs/" + mobName  + ".png")
