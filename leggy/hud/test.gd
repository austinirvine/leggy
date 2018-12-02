extends Node

func _ready():
	$HUD.connect("game_over", self, "handle_game_over")
	$HUD.start(30)
	$HUD.message("Hurry up and get that leg off, soldier!\n(swipe the saw left and right)")

func handle_game_over():
	print("Game over")
	$HUD.message("GODDAMNIT JENKINS!\n(you died)")