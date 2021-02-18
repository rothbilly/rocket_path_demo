extends Node2D

var game_point := 0

export(NodePath) onready var timer_node = get_node(timer_node) as Timer 
export(NodePath) onready var time_label = get_node(time_label) as Label
export(NodePath) onready var points_label = get_node(points_label) as Label
export(NodePath) onready var tween_node = get_node(tween_node) as Tween

func _ready():
	EventController.connect("_on_movement_state", self, "_on_movement")
	EventController.connect("_add_coin",self,"_update_points" )
	pass
	
func _process(delta):
	time_label.text = str(round(timer_node.time_left)) + " S"


func _on_Timer_timeout():
	EventController.emit_signal("update_timer", false)
	##$Background/Bg1.get_material().set_shader_param("velocity",-1)


func _on_movement(state: bool):
		timer_node.set_paused(state)

func _update_points(points):
	game_point += points
	points_label.text =str(game_point)
	pass
	
