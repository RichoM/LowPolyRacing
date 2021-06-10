extends VehicleBody

const MAX_SPEED = 750
const MAX_STEERING = 0.25
const ACCELERATION = 0.75

onready var camera = $Camera

func _process(delta):
	self.axis_lock_linear_y = self.axis_lock_linear_y || self.linear_velocity.length() > 10
	
	if Input.is_action_pressed("ui_up"):
		engine_force = -ACCELERATION * MAX_SPEED
	elif Input.is_action_pressed("ui_down"):
		engine_force = ACCELERATION * MAX_SPEED * 0.5
	else: 
		engine_force *= 0.75
	
	var target_steering = 0
	if Input.is_action_pressed("ui_left"):
		target_steering = MAX_STEERING
	elif Input.is_action_pressed("ui_right"):
		target_steering = -MAX_STEERING
	
	steering = lerp(steering, target_steering, 4 * delta)
	if camera:
		camera.h_offset = -steering * 1.5
