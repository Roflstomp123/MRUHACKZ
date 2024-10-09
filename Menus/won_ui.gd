extends Control
class_name WonUI
@onready var congrats: Label = $VBoxContainer/Label
@onready var continue_button:Button = $VBoxContainer/HBoxContainer/StartButton
@onready var quit_button: Button = $VBoxContainer/HBoxContainer/QuitButton
@onready var label_2: Label = $VBoxContainer/ConfirmContainer/VBoxContainer/Label2


signal Continue


func set_level_text(text:String):
	await  get_tree().process_frame
	label_2.text = text

func _on_start_button_pressed() -> void:
	visible = false
	Continue.emit()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
