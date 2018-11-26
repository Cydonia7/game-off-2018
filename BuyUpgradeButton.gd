extends Button

export(Texture) var texture
export(String) var upgrade
export var cost = 100
var dependencies = []
var is_wave_running = false

func _enter_tree():
	EventListener.add_listener(self, ['money_changed', 'upgrade_bought', 'wave_started', 'wave_finished'])
	if upgrade == 'three_missiles':
		dependencies = ['two_missiles']
	if upgrade == 'fastest_missiles':
		dependencies = ['faster_missiles']

func on_money_changed(coins):
	check_availability()

func on_upgrade_bought(upgrade):
	check_availability()

func check_availability():
	if get_game_manager().has_upgrade(upgrade):
		set_disabled(true)
		return
	
	var has_dependencies = true
	for dependency in dependencies:
		if not get_game_manager().has_upgrade(dependency):
			has_dependencies = false
	
	set_disabled(!get_game_manager().can_buy(cost) || !has_dependencies)

func _ready():
	connect("pressed", self, "on_clicked")
	$Sprite.texture = texture
	$Panel.set_visible(cost != 0)
	$Panel/Label.text = str(cost)

func on_clicked():
	if get_game_manager().can_buy(cost) && !is_wave_running:
		get_game_manager().buy(cost)
		get_game_manager().add_upgrade(upgrade)
		check_availability()

func on_wave_started(data):
	is_wave_running = true

func on_wave_finished(data):
	is_wave_running = false

func get_game_manager():
	return get_tree().get_nodes_in_group("game_manager")[0]
