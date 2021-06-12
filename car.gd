extends VehicleBody
class_name Car

const MAX_SPEED = 750
const MAX_STEERING = 0.25
const ACCELERATION = 0.75

onready var camera = $Camera
onready var engine_sfx = $engine_sfx

signal new_record

var input_enabled : bool = false
var checkpoints = []
var laps = 0
var lap_begin = 0
var cur_time = 0
var last_time = 0
var best_time = INF

func entered_checkpoint(checkpoint : int, total : int):
	if checkpoints.size() == 0:
		if checkpoint != 0:
			print("Wrong checkpoint!")
			return
	else:
		var last_checkpoint = checkpoints.back()
		if checkpoint == 0 and last_checkpoint == total - 1:
			print("Lap end!")
			laps += 1
			last_time = OS.get_ticks_msec() - lap_begin
			if last_time < best_time: 
				best_time = last_time
				emit_signal("new_record")
			print("TIME: ", last_time)
			checkpoints.clear()
		elif checkpoint <= last_checkpoint or checkpoint - last_checkpoint != 1: 
			print("Wrong checkpoint!")
			return
	
	checkpoints.append(checkpoint)
	if checkpoints.size() == 1:
		print("Lap begin!")
		lap_begin = OS.get_ticks_msec()
	else:
		print("Checkpoint!")

func _process(delta):
	if lap_begin > 0: cur_time = OS.get_ticks_msec() - lap_begin
	
	if !input_enabled: return
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
	self.axis_lock_linear_y = self.axis_lock_linear_y || velocity > 20
	
	if camera:
		camera.h_offset = -steering * 1.5
		camera.fov = lerp(60, 90, velocity / 75)
		camera.fov = min(camera.fov, 90)
		
	if engine_sfx:
		engine_sfx.pitch_scale = lerp(0.01, 1.0, velocity / 75)
		engine_sfx.pitch_scale = min(engine_sfx.pitch_scale, 2)
		engine_sfx.volume_db = lerp(-20, 0, engine_sfx.pitch_scale/1.5) + 5
		if Input.is_action_just_released("mute"):
			engine_sfx.playing = !engine_sfx.playing
	
