extends Sprite2D

enum FRAMETYPE{bad,good,energy}

@export var state: FRAMETYPE
@onready var animation = $AnimationPlayer

func _ready():
	EventController.connect("failed_to_move", Callable(self, "_show_frame"))
	#$AnimationPlayer.connect("animation_finished",self)


func _show_frame(index):
	state = index
	self.show()
	if state == FRAMETYPE.good:
		$Sprite2D.frame = 1
	if state == FRAMETYPE.bad:
		$Sprite2D.frame = 0
	if state == FRAMETYPE.energy:
		$Sprite2D.frame = 2
	$AnimationPlayer.play("Open")
	await get_tree().create_timer(2).timeout
	_hide_frame()


func _hide_frame():
	$AnimationPlayer.play_backwards("Open")
	await get_node("AnimationPlayer").animation_finished
	self.hide()
