extends GridObject
class_name Meteor

var initialrotation 

onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	initialrotation = rand_range(0, 360)
	$Sprite.rotation_degrees = initialrotation
	animation.play("Rotate")

