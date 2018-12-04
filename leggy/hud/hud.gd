extends Control

const GAME_SCENE = preload("res://Assets/game.tscn")
const MENU_SCENE = preload("res://menu/menu.tscn")

signal game_over
var target_message = ""
var current_message_position = 0
var finish_time = 0.0

func _ready():
	$Timer.connect("timeout", self, "handle_timeout")
	$TryAgain.connect("pressed", self, "handle_tryagain_pressed")
	$Exit.connect("pressed", self, "handle_exit_pressed")

func handle_timeout():
	$TimeLabel.text = "00"
	$TryAgain.show()
	$Exit.show()

	emit_signal("game_over")

func handle_tryagain_pressed():
	get_tree().change_scene_to(GAME_SCENE)

func handle_exit_pressed():
	get_tree().change_scene_to(MENU_SCENE)

func start(time):
	# Make sure we haven't already started
	assert($Timer.is_stopped())

	$Timer.wait_time = time
	$Timer.start()
	set_process(true)

func stop():
	finish_time = $Timer.time_left
	$Timer.stop()
	
	$TryAgain.text = "Again!"
	$TryAgain.show()
	$Exit.text = "We're done here"
	$Exit.show()

func message(text):
	current_message_position = 0
	target_message = text
	$MessageLabel.text = ""
	$Officer/AnimationPlayer.play("talk")

func _process(delta):
	if finish_time != 0.0:
		$TimeLabel.text = ("%.0f" % [finish_time]).pad_zeros(2)
	else:
		$TimeLabel.text = ("%.0f" % [$Timer.time_left]).pad_zeros(2)

	if current_message_position < target_message.length():
		$MessageLabel.text += target_message[current_message_position]
		current_message_position += 1
		if current_message_position == target_message.length():
			$Officer/AnimationPlayer.stop()