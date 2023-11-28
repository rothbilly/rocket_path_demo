extends Sprite2D
class_name MovementIndicator

enum STATE{selected, active, playing, success, error, blocked}
enum ACTION{left, go, right, nothing}

@export (NodePath) onready var animation_tree = get_node(animation_tree) as AnimationTree
@onready var animation_state = animation_tree["parameters/playback"] as AnimationNodeStateMachinePlayback

@export var frame_state: STATE
@export var action: ACTION


func _ready():
	
	setup_action(action)
	setup_state(frame_state)
	pass
	
func _process(delta):
	#setup_action(action)
	#setup_state(frame_state)
	pass


func setup_state(new_state) -> void:
	match new_state:
		STATE.selected:
			animation_state.travel("Selected")
			self.frame = 0
			$Halo.frame = 5
			#animation_tree.set(pst)
			pass
		STATE.active:
			animation_state.travel("Nothing")
			self.frame = 0
			$Halo.frame = 5
			pass
		STATE.success:
			self.frame = 2
			$Halo.frame = 7
			pass
		STATE.error:
			self.frame = 1
			$Halo.frame = 6
			pass
		STATE.blocked:
			self.frame = 3
			$Halo.frame = 8
			pass
		STATE.playing:
			animation_state.travel("Hover")
			pass
	frame_state = new_state

func setup_action(new_action) -> void:
	match new_action:
		ACTION.go:
			$Sprite2D.frame = 0
			pass
		ACTION.left:
			$Sprite2D.frame = 1
			pass
		ACTION.right:
			$Sprite2D.frame = 2
			pass
		ACTION.nothing:
			animation_state.travel("Clear")
			$Sprite2D.frame = 3
			pass
	action = new_action
	
