extends Control


func _on_main_menu_pressed():
	Gamemanager.change_scene("Menu")
	pass

func _on_play_again_pressed():
	get_tree().reload_current_scene()
