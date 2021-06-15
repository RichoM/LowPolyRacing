extends Spatial

export var interval = 1000
export var type = "R"
signal triggered

var t1 = 0
var t2 = 0

func _on_first_body_entered(body):
	t1 = OS.get_ticks_msec()

func _on_second_body_entered(body):
	t2 = OS.get_ticks_msec()
	trigger_notification()
	
func trigger_notification():
	if t2 - t1 < interval and t1 < t2:
		print(">>>>>> " + type)
		emit_signal("triggered", type)
	t1 = 0
	t2 = 0
