extends Node2D

export(PackedScene) var cannonScene
export(Texture) var cannonTexture
export(int) var cost

var was_pressed = false
var can_place_tower = true
var is_colliding = false
var money = 0

func _enter_tree():
	EventListener.add_listener(self, ['wave_started', 'wave_finished'])

func on_turret_entered():
	is_colliding = true

func on_turret_exited():
	is_colliding = false

func _process(delta):
	get_node('Area/Sprite').texture = cannonTexture
	
	if not (cannonScene and cannonTexture):
		return
	
	set_global_position(get_global_mouse_position())
	
	var in_level = global_position.y + get_node('Area/Sprite').texture.get_height() / 2 < 600
	var game_manager = get_game_manager()
	var has_enough_money = get_game_manager().can_buy(cost)
	
	get_node('Area/Sprite').set_visible(in_level && !is_colliding && can_place_tower && has_enough_money)
	
	if not can_place_tower:
		return
	
	if was_pressed && !Input.is_mouse_button_pressed(BUTTON_LEFT):
		was_pressed = false
		
		if in_level && !is_colliding && has_enough_money:
			var cannon = cannonScene.instance()
			cannon.set_global_position(get_global_mouse_position())
			get_node('../Level/Cannons').add_child(cannon)
			get_game_manager().buy(cost)
	elif not was_pressed && Input.is_mouse_button_pressed(BUTTON_LEFT) && in_level:
		was_pressed = true

func on_wave_started(data):
	can_place_tower = false

func on_wave_finished(data):
	can_place_tower = true

func get_game_manager():
	return get_tree().get_nodes_in_group("game_manager")[0]
