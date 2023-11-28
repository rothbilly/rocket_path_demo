extends Marker2D
class_name GridCreator

const METEOR: PackedScene = preload("res://Scenes/Meteoro.tscn")
const COIN: PackedScene = preload("res://Scenes/Coin.tscn")

const TILE_DISTANCE: int = 128
var grid_position: Vector2
var main_dir: Dictionary = {}

var player_pos = Vector2(3,0)
var steps: int 

@export (int, 3, 10) var render_column: int = 9
@export var row_gridsize: int = 7 # (int, 3, 9)
@export var my_seed: int = 131 # (int, 100, 999)

var random_seed = rand_seed(my_seed)

func _init():
	pass

func _ready():
	EventController.connect("update_timer", Callable(self, "_update_all"))
	EventController.connect("_on_movement_state", Callable(self, "_update_all"))
	
	randomize()
	#print(random_seed)
	generate_grid()


func _update_all(state):
	if state == false:
		steps +=1
		move_grid()
		add_row()
		delete_row()


func generate_grid(): ## generate a dictionary, gridmap generator 
	for i in range(row_gridsize):
		main_dir[Vector2(i,0)] = null
	
	for j in range(1, render_column):
		for i in range(row_gridsize):
			var block = randi()%5
			var pos = Vector2(i,-j)
			if block == 0:
				main_dir[pos] = _InstanceItem(METEOR, pos)
				##_InstanceItem(METEOR, Vector2(i,-j))
			elif block ==1:
				main_dir[pos] = _InstanceItem(COIN, pos)
			else:
				main_dir[pos] = null


func add_row():
	for i in range(row_gridsize):
		var pos = Vector2(i,-render_column)
		if randi()%5 == 0:
			main_dir[pos] = _InstanceItem(METEOR, Vector2(i,-render_column+steps))
		elif randi()%5 == 1:
			main_dir[pos] = _InstanceItem(COIN, Vector2(i,-render_column+steps))
		else:
			main_dir[pos] = null
	render_column += 1


func delete_row():
	for i in range(row_gridsize):
		var pos = Vector2(i,1-steps)
		clear_object(pos)
		main_dir.erase(pos)


func move_grid():
	for xy in main_dir:
		if main_dir[xy] as GridObject:
			main_dir[xy].move_down()


func _InstanceItem(item, tile_position):
	var tile_instance = item.instance()
	tile_instance.position = tile_position*TILE_DISTANCE
	self.add_child(tile_instance)
	return tile_instance


func clear_object(point: Vector2):
	if main_dir[point] is Area2D:
		main_dir[point].queue_free()
		
