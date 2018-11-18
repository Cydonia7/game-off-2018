extends Node2D

var waves = [
	{
		'number_of_groups': 4,
		'mobs_per_group': 3,
		'mobs': ['cyclo fumeur'],
	},
	{
		'number_of_groups': 8,
		'mobs_per_group': 3,
		'mobs': ['cyclo fumeur', 'poulpi'],
	},
	{
		'number_of_groups': 8,
		'mobs_per_group': 3,
		'mobs': ['cyclo fumeur', 'medusar', 'poulpi', 'medusar'],
	},
	{
		'number_of_groups': 8,
		'mobs_per_group': 4,
		'mobs': ['lunique', 'poulpi', 'medusar', 'poulpi'],
	},
	{
		'number_of_groups': 8,
		'mobs_per_group': 4,
		'mobs': ['lunique', 'medusar', 'Mr. citrus', 'poulpi'],
	},
	{
		'number_of_groups': 10,
		'mobs_per_group': 5,
		'mobs': ['lunique', 'medusar', 'Mr. citrus', 'libeluliste'],
	},
	{
		'number_of_groups': 12,
		'mobs_per_group': 5,
		'mobs': ['lunique', 'Mr. citrus', 'libeluliste', 'menthe religieuse'],
	},
]

func _enter_tree():
	EventListener.add_listener(self, ['wave_started', 'wave_finished'])

func on_wave_started(wave):
	var spawner = preload('res://WaveSpawner.tscn').instance()
	add_child(spawner)
	
	spawner.waves = waves[wave - 1].number_of_groups
	spawner.enemies_per_wave = waves[wave - 1].mobs_per_group
	spawner.mobs = waves[wave - 1].mobs

func on_wave_finished(wave):
	for child in get_node('Cannons').get_children():
		child.queue_free()
	
	if wave >= waves.size():
		get_tree().change_scene("res://GameWon.tscn")
