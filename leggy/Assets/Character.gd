extends Spatial

# Progress
var progress = 0
var first_move = 0
var cut_threshold = false
# Accelerometer
#var acc_threshold = 1
# Gyroscope
#var gyr_threshold = 1

# Blood Signal
var blood_speed = 10
signal _on_sawing(sawing)

# Operating System
var op_sys

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting")

	op_sys = OS.get_name()
	if op_sys == "Android":
		pass
	elif op_sys == "iOS":
		pass
