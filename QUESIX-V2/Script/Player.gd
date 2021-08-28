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
	EventController.connect("_on_movement_state", self,"_move_back")
	
	position = player_vector*tile_distance
	next_player_pos = position


func _move(direction: Vector2) -> void:
	can_move = _check_next_pos()
	if !tween_node.is_active() and can_move:
		player_vector += direction.rotated(rotation)
		
		player_vector.x = clamp(player_vector.x,0,6)
		player_vector.y = clamp(player_vector.y,-8,0)
		_execute_move(player_vector)
		


func _move_back(state):
	if state == false:
		player_vector += Vector2(0,1)
		_check_game_over()
		player_vector.y = clamp(player_vector.y,-8,0)
		_execute_move(player_vector)
		

func _check_game_over():
		if player_vector.y > 0:
			EventController.emit_signal("_on_dead")
			print("estas muerto")
		return
	
	
func _execute_move(dir: Vector2) -> void:
	next_player_pos = dir*tile_distance
	tween_node.interpolate_property(self, "position",
									position, next_player_pos.snapped(Vector2(128,128)),
									tween_time,Tween.TRANS_EXPO,Tween.EASE_OUT)
	tween_node.start()
	
	
	
func _rotate( rotation_direcction:bool) -> void:
	if !tween_node.is_active():
		if rotation_direcction:
			tween_node.interpolate_property(self,"rotation_degrees",
											rotation_degrees,rotation_degrees+90,
											tween_time,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		else:
			tween_node.interpolate_property(self,"rotation_degrees",
											rotation_degrees,rotation_degrees-90,
											tween_time,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		tween_node.start()
		
func _check_next_pos() -> bool:
	if front_ray.is_colliding():
		var _object = front_ray.get_collider()
		if _object is Meteor:
			EventController.emit_signal("failed_to_move",0)
			return false
	return true
	
func _check_for_point():
	if front_ray.is_colliding():
		var _object = front_ray.get_collider()
		if _object is Coin:
			EventController.emit_signal("_add_coin", _object.point_to_add)
			_object.on_ship_enter()


func _on_Tween_tween_step(object, key, elapsed, value):
	_check_for_point()
	pass # Replace with function body.
