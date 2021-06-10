extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	scale_object_local(Vector3(1, rand_range(0.25, 1.5), 1))


