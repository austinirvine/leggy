extends Spatial

# Saw Locations
var last_point;
var recent_point;

# Progress
var progress = 0
# Accelerometer
#var acc_threshold = 1
# Gyroscope
#var gyr_threshold = 1

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
	_move_saw()

func _saw_loc(point):
	if (progress == 0):
		last_point = point
		return
	recent_point = point
	var saw = get_node( "Saw" )
	var deltaZ = (recent_point.y - last_point.y) / 100
	print(deltaZ)
	saw.translate( Vector3 ( 0.0, 0.0, deltaZ))
	last_point = point

func _move_saw():
	var saw = get_node( "Saw" )
	saw.translate( Vector3 ( 0.0, -.25, 0.0 ))
	progress += 1
	print(progress)
