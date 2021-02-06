#tool
extends Sprite
class_name MovementIndicator


enum STATE{selected, active, success, error, blocked, playing}
enum ACTION{left, go, right, nothing}

export (NodePath) onready var animation_tree = get_node(animation_tree) as AnimationTree
onready var animation_state = animation_tree["parameters/playback"] as AnimationNodeStateMachinePlayback

export(STATE) var frame_state
export(ACTION) var action


func _ready():
	
	setup_action(action)
	setup_state(frame_state)
	pass
	
func _process(delta):
	setup_action(action)
	setup_state(frame_state)


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

func setup_action(new_action) -> void:
	match new_action:
		ACTION.go:
			$Sprite.frame = 0
			pass
		ACTION.left:
			$Sprite.frame = 1
			pass
		ACTION.right:
			$Sprite.frame = 2
			pass
		ACTION.nothing:
			animation_state.travel("Enter")
			$Sprite.frame = 3
			pass
	action = new_action
	
