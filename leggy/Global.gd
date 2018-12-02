extends Node

const MENU_SCENE = preload("res://menu/menu.tscn")

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

	if event.is_action_pressed("quit"):
		get_tree().change_scene_to(MENU_SCENE)