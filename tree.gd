extends Spatial

const inc = 1.02
const dec = 0.98

var growth = inc

func _ready():
	var w = rand_range(1, 1.5)
	var h = rand_range(0.25, 1.5)
	scale_object_local(Vector3(w, h, w))


func _process(delta):
	return
	scale_object_local(Vector3(1, growth, 1))
	rotate_object_local(Vector3.UP, delta)
	if global_transform.basis.y.length() > 2:
		growth = dec
	elif global_transform.basis.y.length() < 0.5:
		growth = inc

