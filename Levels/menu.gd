extends Control

var tween = create_tween()
func _process(delta):
	for i in range(10):
		tween.tween_property($Station, "position", Vector2(1400, 700), 4)
		tween.tween_property($Station, "rotation", 0.2, 8)
		tween.tween_property($Station, "position", Vector2(1300, 800), 8)
		tween.tween_property($Station, "rotation", 0.1, 4)
		tween.tween_property($Station, "position", Vector2(1200, 700), 8)
		tween.tween_property($Station, "rotation", 0, 8)
		tween.tween_property($Station, "position", Vector2(1400, 800), 8)
	pass




func _on_start_button_pressed():
	Gamemanager.change_scene("TempLevel")


func _on_quit_button_pressed():
	$MarginContainer/VBoxContainer/ConfirmContainer.visible = true
	pass 

func _on_leave_button_pressed():
	get_tree().quit()
	
func _on_never_leave_button_pressed():
	$MarginContainer/VBoxContainer/ConfirmContainer.visible = false
	pass
