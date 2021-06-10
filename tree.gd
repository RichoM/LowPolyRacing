extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var w = rand_range(1, 1.5)
	var h = rand_range(0.25, 1.5)
	scale_object_local(Vector3(w, h, w))


