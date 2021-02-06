extends Node2D

class_name Player

export(float, 0.1, 1) var tween_time

var tile_distance: int = 128
var player_vector := Vector2(3,0)
var next_player_pos : Vector2
var can_move: bool

onready var tween_node = get_node("Tween") as Tween
onready var front_ray = get_node("RayCast2D") as RayCast2D


func _ready():
	EventController.connect("front_button", self, "_move")
	EventController.connect("left_button", self, "_rotate")
	EventController.connect("right_button", self, "_rotate")
	EventController.connect("update_timer",self, "_move_back")
	
	position = player_vector*tile_distance
	next_player_pos = position


func _move(direction: Vector2) -> void:
	can_move = _check_next_pos()
	if !tween_node.is_active() and can_move:
		player_vector += direction.rotated(rotation)
		
		player_vector.x = clamp(player_vector.x,0,6)
		player_vector.y = clamp(player_vector.y,-8,0)
		_execute_move(player_vector)


func _move_back():
	player_vector += Vector2(0,1)
	player_vector.y = clamp(player_vector.y,-8,0)
	_execute_move(player_vector)
	
	
func _execute_move(dir: Vector2) -> void:
	next_player_pos = dir*tile_distance
	tween_node.interpolate_property(self, "position",
									position, next_player_pos.snapped(Vector2(128,128)),
									tween_time,Tween.TRANS_EXPO,Tween.EASE_OUT)
	tween_node.start()
	print(player_vector, position)
	
	
func _rotate( rotation_direcction:bool) -> void:
	if !tween_node.is_active():
		if rotation_direcction:
			#rotation_degrees += 90
			tween_node.interpolate_property(self,"rotation_degrees",
											rotation_degrees,rotation_degrees+90,
											tween_time,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		else:
			#rotation_degrees -= 90
			tween_node.interpolate_property(self,"rotation_degrees",
											rotation_degrees,rotation_degrees-90,
											tween_time,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		tween_node.start()
		
func _check_next_pos() -> bool:
	#var front_post = player_vector + Vector2(0,-1).rotated(rotation)
	if front_ray.is_colliding():
		var next_object = front_ray.get_collider() as Area2D
		if next_object is Meteor:
			EventController.emit_signal("failed_to_move",0)
			return false
	return true

