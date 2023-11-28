extends Sprite

enum FRAMETYPE{bad,good,energy}

export(FRAMETYPE) var state
onready var animation = $AnimationPlayer

func _ready():
	EventController.connect("failed_to_move",self,"_show_frame")
	#$AnimationPlayer.connect("animation_finished",self)


func _show_frame(index):
	state = index
	self.show()
	if state == FRAMETYPE.good:
		$Sprite.frame = 1
	if state == FRAMETYPE.bad:
		$Sprite.frame = 0
	if state == FRAMETYPE.energy:
		$Sprite.frame = 2
	$AnimationPlayer.play("Open")
	yield(get_tree().create_timer(2),"timeout")
	_hide_frame()


func _hide_frame():
	$AnimationPlayer.play_backwards("Open")
	yield(get_node("AnimationPlayer"), "animation_finished")
	self.hide()
