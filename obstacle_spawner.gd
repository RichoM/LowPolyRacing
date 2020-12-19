extends Spatial

export(Resource) var obstacle
export var count := 150

func _ready():
	randomize()
	for i in range(count):
		var ins = obstacle.instance()
		var x = rand_range(-20, 20)
		var z = rand_range(-20, 20)
		var y = rand_range(50, 100)
		ins.global_transform.origin = Vector3(x, y, z)
		add_child(ins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
