extends Button

export(PackedScene) var scene
export(Texture) var texture
export var cost = 100

func _enter_tree():
	EventListener.add_listener(self, 'money_changed')

func on_money_changed(coins):
	set_disabled(coins < cost)

func _ready():
	connect("pressed", self, "on_clicked")
	$Sprite.texture = texture
	$Panel.set_visible(cost != 0)
	$Panel/Label.text = str(cost)

func on_clicked():
	get_cannon_spawner().cannonScene = scene
	get_cannon_spawner().cannonTexture = texture
	get_cannon_spawner().cost = cost

func get_cannon_spawner():
	return get_tree().get_nodes_in_group("cannon_spawner")[0]
