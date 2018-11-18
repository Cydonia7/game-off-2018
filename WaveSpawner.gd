extends Node2D

export var time_between_enemies = 0.4
export var enemies_per_wave = 3
export var time_between_waves = 1.2
export var waves = 4
export var mobs = ['cyclo fumeur']

var time = 0.0
var enemy_index = 0
var wave_index = 0

func _ready():
	randomize()

func _process(delta):
	time += delta
	
	if (time >= time_between_enemies && enemy_index % enemies_per_wave != 0) or time >= time_between_waves:
		wave_index = wave_index + 1 if time >= time_between_waves else wave_index
		
		if wave_index > waves:
			return
		
		time -= time_between_waves if time >= time_between_waves else time_between_enemies
		var follow = preload("res://MovingMob.tscn").instance()
		follow.mobName = mobs[enemy_index % mobs.size()]
		get_node('../MobPath').add_child(follow)
		enemy_index += 1
