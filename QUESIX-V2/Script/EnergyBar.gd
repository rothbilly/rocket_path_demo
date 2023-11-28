extends PanelContainer

export(Array, NodePath) onready var movements 


func _ready():
	for i in movements:
		print (movements[i])
