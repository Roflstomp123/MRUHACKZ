extends Button
class_name TurretOrderingNode

@export var modifier:AttackModifier
@export var button:int = 0:
	set(val):
		button = val 
		var temp = StringName(str(button))
		if shortcut:
			#TODO figure out key shortcuts
			#they're not being set for some reason
			set_shortcut_key.call_deferred(str(button))
			pass
			var temp_2 = shortcut.events[0].get_action()
			pass
		pass


func set_shortcut_key(num:String):
	shortcut.events[0].set_action(StringName(num))
	pass

var cannon_sprite = preload("res://Assets/cannon_single_white.png")

signal CreateTurretAt(index:int)

func _ready():
	#runs the setter
	button = button
	pass

func _set_cannon(_make_visible:bool, color:Color):
	"""
	NOT IN USE!
	"""
	if _make_visible:
		icon = cannon_sprite
	else:
		icon = null
	modulate = color


func _on_pressed() -> void:
	CreateTurretAt.emit(button)
	icon = cannon_sprite
	#random color
	#TODO make the color apply to the icon. Not sure if possible.
	modulate = Color(randi_range(0,255),randi_range(0,255),randi_range(0,255))
	pass # Replace with function body.
