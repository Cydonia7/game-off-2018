extends Button

func _ready():
	connect("pressed", self, "on_clicked")
	get_node('../Shop').set_visible(false)

func on_clicked():
	get_node('../Shop').set_visible(true)
