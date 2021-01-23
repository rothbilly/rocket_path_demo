extends Node2D

class_name Player

var tile_distance = 128
var player_pos = Vector2(3,0)

onready var tween_node = get_node("Tween") as Tween

func _ready():
	EventController.connect("front_button", self, "_move")
	EventController.connect("left_button", self, "_rotate")
	EventController.connect("right_button", self, "_rotate")
	pass


func _move(direction: Vector2) -> void:
	direction =direction.rotated(rotation)
	_update_global_position(direction)
	
	position += direction * tile_distance
	
	pass
	
func _rotate( rotation_direcction:bool) -> void:
	if rotation_direcction:
		rotation_degrees += 90
	else:
		rotation_degrees -= 90
		

func _update_global_position(vector: Vector2) -> void:
	player_pos += vector
	print(player_pos)
