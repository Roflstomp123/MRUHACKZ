extends MarginContainer

const SHORTCUT_INVENTORY_ITEM = preload("res://Menus/shortcut_inventory_item.tscn")

@onready var shortcuts: GridContainer = $Panel/GridContainer2/MainHolder/ScrollContainer/Shortcuts

func _ready():
	
	
	## build shortcuts menu
	#TODO could make a set ammount and make them invisible so the text doesn't keep movign.
	
	for mod in ModifiersSingleton.modifiers:
		var new_item: = SHORTCUT_INVENTORY_ITEM.instantiate()
		new_item.modifier = mod
		shortcuts.add_child(new_item)
		pass
	
	
	pass
