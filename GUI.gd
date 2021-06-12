extends Control

export (NodePath) onready var player  = get_node(player) as Car

onready var lap_counter : Label = $left_col/lap_counter
onready var cur_time : Label = $right_col/cur_time
onready var last_time : Label = $right_col/last_time
onready var best_time : Label = $right_col/best_time

func _process(_delta):
	if player.cur_time:
		lap_counter.text = "LAP  " + str(player.laps + 1)
		cur_time.text = format(player.cur_time)
	else:
		lap_counter.text = ""
		cur_time.text = ""
	
	if player.laps > 0:
		last_time.text = "LAST " + format(player.last_time)
		best_time.text = "BEST " + format(player.best_time)
	else:
		last_time.text = ""
		best_time.text = ""

func format(duration):
	var ms = floor(duration%1000)/10
	var s = floor((duration/1000)%60)
	var m = floor((duration/(1000*60))%60)
	return "%02d:%02d:%02d" % [m, s, ms]
