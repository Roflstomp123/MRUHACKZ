extends Button
class_name TurretOrderingNode

@onready var texture_rect: TextureRect = $TextureRect


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
		texture_rect.texture = cannon_sprite
	else:
		texture_rect.texture = null
	#modulate = color


func _on_pressed() -> void:
	CreateTurretAt.emit(button)
	texture_rect.texture = cannon_sprite
	
	
	#random color
	ModifiersSingleton.turret_colors[button - 1] = Color(randf(),randf(),randf())
	#need the texture_rect to only change the color of the texture rather than the panel behind it as well.
	texture_rect.self_modulate = ModifiersSingleton.turret_colors[button - 1]
	text = ""
	pass # Replace with function body.
