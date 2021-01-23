extends Position2D
class_name GridCreator

const METEOR: PackedScene = preload("res://Scenes/Meteoro.tscn")

var tile_distance = 128
var render_column: int = 9
var grid_position: Vector2
var main_dic: Dictionary = {}
var player_pos = Vector2(3,0)

export(int,3, 9) var row_gridsize: int = 7
export(int, 100, 999) var my_seed: int = 131

var random_seed = rand_seed(my_seed)


func _init():
	pass

func _ready():
	randomize()
	generate_grid()
	
	print(random_seed)
	#clear_object(Vector2(1,-6))

func generate_grid():
	
	for i in range(row_gridsize):
		main_dic[Vector2(i,0)] = 0
	
	for j in range(1, render_column):
		
		for i in range(row_gridsize):
			var block = randi()%5
			if block == 0:
				main_dic[Vector2(i,-j)] = _InstanceItem(METEOR, Vector2(i,-j))
				##_InstanceItem(METEOR, Vector2(i,-j))
			else:
				main_dic[Vector2(i,-j)] = 0

func add_row():
	pass
	
func update_grid():
	
	pass
	
func move():
	pass
	
func _InstanceItem(item, tile_position):
	var tile_instance = item.instance()
	tile_instance.position = tile_position*tile_distance
	self.add_child(tile_instance)
	return tile_instance

func clear_object(point):
	if main_dic[point] is Area2D:
		main_dic[point].queue_free()
