extends Node

var done := false
var next_message := 0
var messages = [
	["Hurry up and get that leg off, soldier!\n(swipe left and right)", 15.0],
	["Faster! Put your back into it! Long strokes!", 10.0],
	["DAMNIT, FASTER!!", 3.8],
	["ASDFSDGJFhfip uhDf78hDFS&SDfhuSI DF*&SDFH*(S&Hfcvadsvas iuHIDFuIOSUd", 1.0],
	]

func _ready():
	$HUD.connect("game_over", self, "handle_game_over")
	$HUD.start(30)
	$MessageTimer.connect("timeout", self, "_message_timeout")
	_message_timeout()

func _message_timeout():
	if next_message < messages.size() and !done:
		$HUD.message(messages[next_message][0])
		$MessageTimer.start(messages[next_message][1])
		next_message += 1

func handle_game_over():
	print("Game over")
	done = true
	$HUD.message("JENKINS NOOOOOO!\n(you died)")
