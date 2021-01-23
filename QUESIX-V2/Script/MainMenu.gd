extends Control


func _ready():
	pass # Replace with function body.


func _on_Exit_button_down():
	get_tree().quit()


func _on_Play_button_down():
	#$AnimationPlayer.play_backwards("Start")
	yield(get_tree().create_timer(1.3),"timeout")
	get_tree().change_scene("res://Scenes/Level.tscn")
