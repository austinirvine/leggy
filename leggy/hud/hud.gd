extends Control

signal game_over

func _ready():
	set_process(false)

	$Timer.connect("timeout", self, "handle_timeout")

	# Temp
	#start()

func handle_timeout():
	set_process(false)
	$Label.text = "00"
	emit_signal("game_over")

func start():
	# Make sure we haven't already started
	assert($Timer.is_stopped())

	$Timer.start()
	set_process(true)

func _process(delta):
	$Label.text = ("%.0f" % [$Timer.time_left]).pad_zeros(2)