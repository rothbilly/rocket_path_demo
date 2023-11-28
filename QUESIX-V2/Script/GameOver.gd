extends Control

func _ready():
	EventController.connect("_on_dead", Callable(self, "_on_game_over"))
	pass # Replace with function body.

func _on_game_over():
	self.show()
	get_tree().paused = true
	#self.pause_mode
	pass


func _on_Button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
