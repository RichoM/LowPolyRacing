extends VehicleBody

const MAX_SPEED = 750
const MAX_STEERING = 0.25
const ACCELERATION = 0.75

onready var camera = $Camera
onready var engine_sfx = $engine_sfx

func _process(delta):
	if Input.is_action_just_released("level_reset"):
		get_tree().reload_current_scene()
		
	if Input.is_action_pressed("car_forward"):
		engine_force = -ACCELERATION * MAX_SPEED
	elif Input.is_action_pressed("car_backwards"):
		engine_force = ACCELERATION * MAX_SPEED * 0.5
	else: 
		engine_force *= 0.75
	
	if Input.is_action_pressed("car_brake"):
		brake = 25
	else:
		brake = 0
	
	var target_steering = 0
	if Input.is_action_pressed("car_turnleft"):
		target_steering = MAX_STEERING
	elif Input.is_action_pressed("car_turnright"):
		target_steering = -MAX_STEERING
	
	steering = lerp(steering, target_steering, 4 * delta)
	
	var velocity = linear_velocity.length()
	self.axis_lock_linear_y = self.axis_lock_linear_y || velocity > 10
	
	if camera:
		camera.h_offset = -steering * 1.5
		camera.fov = lerp(60, 90, velocity / 75)
		camera.fov = min(camera.fov, 90)
		
	if engine_sfx:
		engine_sfx.pitch_scale = lerp(0, 1.0, velocity / 75)
		engine_sfx.pitch_scale = min(engine_sfx.pitch_scale, 2)
		engine_sfx.volume_db = lerp(-20, 0, engine_sfx.pitch_scale/1.5)
