extends VehicleBody

const MAX_SPEED = 500

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		engine_force = 1 * MAX_SPEED
	elif Input.is_action_pressed("ui_down"):
		engine_force = -1 * MAX_SPEED
	else: 
		engine_force = 0
		
	if Input.is_action_pressed("ui_left"):
		steering += 1 * delta
	elif Input.is_action_pressed("ui_right"):
		steering -= 1 * delta
	else:
		steering = 0
		
	steering = clamp(steering, -1, 1)
