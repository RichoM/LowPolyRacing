extends Area

export var number = 0
onready var total = get_parent().get_child_count()

func _on_checkpoint_body_entered(body):
	var car = body as Car
	if car: car.entered_checkpoint(number, total)
		
		
