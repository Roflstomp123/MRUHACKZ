extends Control

const TEMP_LEVEL = preload("res://Levels/temp_level.tscn")

var tween = create_tween()
func _process(delta):
	for i in range(10):
		tween.tween_property($Station, "position", Vector2(1400, 700), 4)
		tween.tween_property($Station, "rotation", 0.2, 8)
		tween.tween_property($Station, "position", Vector2(1300, 800), 4)
		#tween.tween_property($Station, "rotation", -0.2, 4)
		tween.tween_property($Station, "position", Vector2(1200, 700), 4)
		tween.tween_property($Station, "rotation", 0, 8)
		tween.tween_property($Station, "position", Vector2(1400, 700), 4)
	pass




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
