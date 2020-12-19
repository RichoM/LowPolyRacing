extends VehicleBody

const MAX_SPEED = 500
const MAX_STEERING = 0.35
const ACCELERATION = 0.75


func _process(delta):
	if Input.is_action_pressed("ui_up"):
		engine_force = ACCELERATION * MAX_SPEED
	elif Input.is_action_pressed("ui_down"):
		engine_force = -ACCELERATION * MAX_SPEED
	else: 
		engine_force = 0
	
	var target_steering = 0	
	if Input.is_action_pressed("ui_left"):
		target_steering = MAX_STEERING
	elif Input.is_action_pressed("ui_right"):
		target_steering = -MAX_STEERING
	
	steering = lerp(steering, target_steering, 3 * delta)
