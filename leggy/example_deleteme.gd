extends Node

func _ready():
	HUD.connect("game_over", self, "handle_game_over")

func handle_game_over():
	print("Game over!")
