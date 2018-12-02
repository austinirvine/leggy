extends Control

const GAME_SCENE = preload("res://Assets/game.tscn")

func _ready():
	$StartButton.connect("pressed", self, "handle_startbutton_pressed")
	$ExitButton.connect("pressed", get_tree(), "quit")

func handle_startbutton_pressed():
	get_tree().change_scene_to(GAME_SCENE)
