extends Button

func _ready():
	connect("pressed", self, "on_clicked")

func on_clicked():
	EventListener.trigger('next_wave')
