extends Node

var done = false

func _ready():
	$HUD.connect("game_over", self, "handle_game_over")
	$HUD.start(30)

	$HUD.message("Hurry up and get that leg off, soldier!\n(swipe the saw left and right)")
	yield(get_tree().create_timer(15.0), "timeout")

	if done: return

	$HUD.message("Faster! Put your back into it!") # 20 seconds remain
	yield(get_tree().create_timer(10.0), "timeout")

	if done: return

	$HUD.message("DAMNIT, FASTER!!") # 10 seconds remain
	yield(get_tree().create_timer(3.8), "timeout")

	if done: return

	$HUD.message("ASDFSDGJFhfip uhDf78hDFS&SDfhuSI DF*&SDFH*(S&Hfcvadsvas iuHIDFuIOSUd")

func handle_game_over():
	print("Game over")
	done = true
	$HUD.message("JENKINS NOOOOOO!\n(you died)")