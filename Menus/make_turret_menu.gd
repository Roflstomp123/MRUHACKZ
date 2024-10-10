extends MarginContainer

const SHORTCUT_INVENTORY_ITEM = preload("res://Menus/shortcut_inventory_item.tscn")

@onready var shortcuts: GridContainer = $Panel/GridContainer2/MainHolder/ScrollContainer/Shortcuts
@onready var create_turret_popup: Label = $CreateTurretPopup
@onready var placing_buttons: GridContainer = $Panel/GridContainer2/PlacingButtons
@onready var use_slots: GridContainer = $Panel/GridContainer2/MainHolder/UseSlots

#TODO let you examine an existing turret?

func _input(event: InputEvent) -> void:

	if event.is_action_pressed("open_turret_menu"):
			## unpausing handled by the menu itself
			visible = not visible
			get_tree().paused = visible
		
	

func _ready():
	
	for node in placing_buttons.get_children():
		if node is TurretOrderingNode:
			node.CreateTurretAt.connect(_placing_turret_pressed)
	
	## build shortcuts menu
	#TODO could make a set ammount and make them invisible so the text doesn't keep movign.
	
	for mod in ModifiersSingleton.modifier_list:
		var new_item: = SHORTCUT_INVENTORY_ITEM.instantiate()
		new_item.modifier = mod
		shortcuts.add_child(new_item)
		pass
	
	
	pass

func _placing_turret_pressed(button:int) -> void:
	var new_modifier:AttackModifier = AttackModifier.new()
	for node in use_slots.get_children():
		if node is ShortcutInventoryItem:
			new_modifier.add(node.modifier)
	#TODO remove
	print("placing turret was pressed \n\n\n\n\n\n\n\n")
	ModifiersSingleton.turret_modifiers[button -1] = new_modifier
	
	create_turret_popup.visible = false
	
	for node in placing_buttons.get_children():
		if node is TurretOrderingNode:
			node.disabled = true


func _on_create_button_pressed() -> void:
	
	create_turret_popup.visible = true
	for node in placing_buttons.get_children():
		if node is TurretOrderingNode:
			node.disabled = false
	
