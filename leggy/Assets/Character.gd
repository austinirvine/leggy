extends Spatial

# Saw Locations
var last_point;
var recent_point;

# Progress
var progress = 0
var first_move = 0
var cut_threshold = false
# Accelerometer
#var acc_threshold = 1
# Gyroscope
#var gyr_threshold = 1

# Audio
onready var audio_player_in = get_node("AudioStreamPlayer3D_in")
onready var audio_player_out = get_node("AudioStreamPlayer3D_out")
#var saw_in = preload("res://SawIn_1.wav")
#var saw_out = preload("res://SawOut_1.wav")

# Operating System
var op_sys

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting")

	last_point = Vector2(0.0, 0.0);
	recent_point = Vector2(0.0, 0.0);

	op_sys = OS.get_name()
	if op_sys == "Android":
		pass
	elif op_sys == "iOS":
		pass
	pass # Replace with function body.

func _swipe_signal(dir):
	print(dir)

func _saw_loc(point, dir):
	print(dir)
	if (first_move == 0):
		last_point = point
		first_move = 1
		return
	recent_point = point
	var saw = get_node( "Saw" )
	var deltaZ = (recent_point.y - last_point.y) / 100
	saw.translate( Vector3 ( 0.0, 0.0, deltaZ))
	last_point = point
	_make_cut(saw, last_point.y)

func _make_cut(saw, zLoc):
	#print(zLoc)
	if cut_threshold == false && zLoc < 200:
		cut_threshold = true
		audio_player_out._set_playing(true)
		audio_player_in._set_playing(false)
		pass
	elif cut_threshold == true && zLoc > 300:
		cut_threshold = false
		audio_player_out._set_playing(false)
		audio_player_in._set_playing(true)
		saw.translate( Vector3 ( 0.0, -0.15, 0.0 ))
		progress += 1

	#leg change to ragdoll
	if (progress == 15) :
		var leg = get_node("Leg")
		var calf_withrag = leg.get_node("calf-withrag")
		var calf_norag = leg.get_node("calf-norag")

		leg.remove_child( calf_norag )
		calf_withrag.set_visible(true)
		calf_withrag.pause_mode = Node.PAUSE_MODE_INHERIT
		pass
	#print(progress)

func _saw_pitch(delta) :
	var pitch_value = audio_player_in.get_pitch_scale() * delta / 10
	audio_player_in.set_pitch_scale(delta + audio_player_in.get_pitch_scale())
	audio_player_out.set_pitch_scale(delta + audio_player_out.get_pitch_scale())

	if(delta > .1) :
		audio_player_in.set_pitch_scale(1)
		audio_player_out.set_pitch_scale(1)
	pass