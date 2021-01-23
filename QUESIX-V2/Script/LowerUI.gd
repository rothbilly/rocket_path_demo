extends Control


func _ready():
	pass


func _on_Left_pressed():
	EventController.emit_signal("left_button", false)


func _on_Move_pressed():
	EventController.emit_signal("front_button", Vector2(0,-1))


func _on_Right_pressed():
	EventController.emit_signal("right_button", true)
