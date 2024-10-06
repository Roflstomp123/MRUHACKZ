extends Control
class_name WonUI
@onready var congrats: Label = $VBoxContainer/Label

var round_name:String:
	set(val):
		round_name = val
		congrats.text = "Congratulations \n you beat " + round_name
		

signal Continue

func _on_start_button_pressed() -> void:
	visible = false
	Continue.emit()
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
