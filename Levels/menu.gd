extends Control

const TEMP_LEVEL = preload("res://Levels/temp_level.tscn")

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(TEMP_LEVEL)


func _on_quit_button_pressed():
	$MarginContainer/VBoxContainer/ConfirmContainer.visible = true
	pass 

func _on_leave_button_pressed():
	get_tree().quit()

func _on_never_leave_button_pressed():
	$MarginContainer/VBoxContainer/ConfirmContainer.visible = false
	pass
