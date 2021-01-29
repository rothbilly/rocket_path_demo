extends Area2D
class_name GridObject

export(NodePath) onready var tween_node_reference =get_node(tween_node_reference) as Tween

func move_down() -> void:
	if tween_node_reference is Tween:
		tween_node_reference.interpolate_property(self, "position", 
						position, position + Vector2(0,128),
						0.5,Tween.TRANS_EXPO,Tween.EASE_OUT)
		tween_node_reference.start()
	else:
		position += Vector2(0,128)
