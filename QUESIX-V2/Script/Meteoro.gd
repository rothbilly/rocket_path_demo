extends GridObject
class_name Meteor

var initialrotation 

@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	initialrotation = randf_range(0, 360)
	$Sprite2D.rotation_degrees = initialrotation
	animation.play("Rotate")

