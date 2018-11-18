extends Timer

func _ready():
	connect("timeout", self, "_on_timer_timeout") 

func _on_timer_timeout():
	EventListener.reset()
	get_tree().change_scene("res://LevelWindow.tscn")
