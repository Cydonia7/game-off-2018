extends Node

var coins = 3000
var lives = 3
var wave = 7
var upgrades = []

func _enter_tree():
	EventListener.add_listener(self, 'next_wave')

func _ready():
	EventListener.trigger('money_changed', coins)
	EventListener.trigger('wave_finished', 0)

func on_monster_killed(reward):
	coins += reward
	EventListener.trigger('money_changed', coins)
	check_if_wave_finished()

func add_upgrade(upgrade):
	upgrades.append(upgrade)
	EventListener.trigger('upgrade_bought', upgrade)

func has_upgrade(upgrade):
	return upgrades.has(upgrade)

func on_monster_missed():
	lives -= 1
	
	if lives == 0:
		get_tree().change_scene("res://GameOver.tscn")
	
	EventListener.trigger('life_changed', lives)
	check_if_wave_finished()

func on_next_wave(data):
	EventListener.trigger('wave_started', wave)

func check_if_wave_finished():
	if is_wave_finished():
		EventListener.trigger('wave_finished', wave)
		wave += 1

func can_buy(price):
	return coins >= price

func buy(price):
	coins -= price
	EventListener.trigger('money_changed', coins)

func get_game_listener():
	return get_tree().get_nodes_in_group("game_listener")[0]

func is_wave_finished():
	return get_mob_path().get_child_count() == 1

func get_mob_path():
	return get_node('../MobPath')
