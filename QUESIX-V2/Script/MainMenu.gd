extends Control

export(Resource) var player_data = player_data as GameData
export(NodePath) onready var name_setup = get_node(name_setup)
export(NodePath) onready var display_text = get_node(display_text) as Label

func _ready():
	if player_data.player_nick_name == "":
		name_setup.show()
	else:
		display_text.text = "Bienvendo de nuevo " + player_data.player_nick_name
	pass # Replace with function body.


func _on_Exit_button_down():
	get_tree().quit()


func _on_Play_button_down():
	#$AnimationPlayer.play_backwards("Start")
	yield(get_tree().create_timer(1.3),"timeout")
	get_tree().change_scene("res://Scenes/Level.tscn")
	
func _enter_nickname():
	var nick_name = $namesetup/Panel/LineEdit.text
	print(nick_name)
	if nick_name != "":
		player_data.player_name_setup(nick_name)
		name_setup.hide()
		display_text.text = "Bienvendo de nuevo " + player_data.player_nick_name
		
