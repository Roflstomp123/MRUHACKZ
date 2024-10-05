extends MarginContainer
class_name ShortcutInventoryItem

@onready var label: Label = $Panel/Label

@export var modifier:AttackModifier = AttackModifier.new():
	set(val):
		modifier = val
		#dumb null check
		if label and modifier:
			label.text = modifier.input_name
		
@export var type:int = INVENTORY

enum {
	INVENTORY,
	BUILD
}

func _ready():
	#runs the setter
	modifier = modifier

func _get_drag_data(at_position: Vector2) -> Variant:
	return modifier

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	#only drop to build
	return type == BUILD and data is AttackModifier
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	#TODO add slide up/down?
	modifier = data
	pass
