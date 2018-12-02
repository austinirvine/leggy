extends Control

signal game_over
var target_message = ""
var current_message_position = 0

func _ready():
	set_process(false)

	$Timer.connect("timeout", self, "handle_timeout")

func handle_timeout():
	set_process(false)
	$TimeLabel.text = "00"

	emit_signal("game_over")

func start():
	# Make sure we haven't already started
	assert($Timer.is_stopped())

	$Timer.start()
	set_process(true)

func message(text : String):
	$MessageLabel.text = ""
	target_message = text
	$Officer/AnimationPlayer.play("talk")

func _process(delta):
	$TimeLabel.text = ("%.0f" % [$Timer.time_left]).pad_zeros(2)

	if current_message_position < target_message.length():
		$MessageLabel.text += target_message[current_message_position]
		current_message_position += 1
		if current_message_position == target_message.length():
			$Officer/AnimationPlayer.stop()