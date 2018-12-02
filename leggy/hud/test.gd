extends Node

func _ready():
	$HUD.connect("game_over", self, "handle_game_over")
	$HUD.start()
	$HUD.message("Hurry up and chop that leg off/n(swipe the saw left and right)")

func handle_game_over():
	print("Game over")