extends GridObject
class_name Coin

export (int) var point_to_add
# Called when the node enters the scene tree for the first time.

func on_ship_enter():
	self.queue_free()
