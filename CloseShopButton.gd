extends Button

func _ready():
	connect("pressed", self, "on_clicked")

func on_clicked():
	get_node('..').set_visible(false)
