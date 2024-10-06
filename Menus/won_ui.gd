extends Control
class_name WonUI
@onready var congrats: Label = $VBoxContainer/Label
@onready var continue_button:Button = $VBoxContainer/HBoxContainer/StartButton
@onready var quit_button: Button = $VBoxContainer/HBoxContainer/QuitButton
@onready var label_2: Label = $VBoxContainer/ConfirmContainer/VBoxContainer/Label2

var round_name:String:
	set(val):
		round_name = val
		if int(round_name) <= 0:
			congrats.text = "Don't let the aliens get \n to your planet! \n Use Ctr + + to make your shot bigger, \n or Ctr + - to make them smaller (and faster)." \
							+ "\n Use tab to create turrets to help you out. \n 1-9 to place them, del to remove them."
			congrats.add_theme_font_size_override("font_size", 60)
			continue_button.text = "START"
			quit_button.visible = false

		else:
			continue_button.text = "CONTINUE"
			congrats.remove_theme_font_size_override("font_size")#.font_size = 128
			congrats.text = "Congratulations \n you beat " + round_name
			ModifiersSingleton.max_turret += int(round_name)
			label_2.text = unlock_per_level_dictionary[int(round_name)][0]
			ModifiersSingleton.modifier_list.append(unlock_per_level_dictionary[int(round_name)][1])
			quit_button.visible = true

var unlock_per_level:Array[String] = [
	"You ulocked a new shortcut! \n Use Alt + D \n To make your lasers follow enemies. \n You unlocked 1 more turret.",
	"You ulocked a new shortcut! \n Use Ctr + Z \n To heal (Cooldown in the bottom left). \n You unlocked 2 more turret."
]

var unlock_per_level_dictionary:Dictionary = {
	"1":  ["You ulocked a new shortcut! \n Use Alt + D \n To make your lasers follow enemies. \n You unlocked 1 more turret.", "res://Player/Modifiers/tracking.tres"] ,
	"2":  ["You ulocked a new shortcut! \n Use Ctr + Z \n To heal (Cooldown in the bottom left). \n You unlocked 2 more turret.", "res://Player/Modifiers/tracking.tres"] # should have ctr z here.
}

## Bad data structures, should keep a 
	
func _ready() -> void:
	#runs the setter for the tutorial.
	await get_tree().process_frame
	round_name = "-1"
	pass

signal Continue

func _on_start_button_pressed() -> void:
	visible = false
	Continue.emit()
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
