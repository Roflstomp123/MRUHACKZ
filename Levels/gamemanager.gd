extends Node

const TEMP_LEVEL = preload("res://Levels/temp_level.tscn")
const MENU = preload("res://Levels/menu.tscn")

func change_scene(new_scene):
	match new_scene:
		"TempLevel":
			get_tree().change_scene_to_packed(TEMP_LEVEL)
		"Menu":
			get_tree().change_scene_to_packed(MENU)
		_:
			print("You are a failure")
	
