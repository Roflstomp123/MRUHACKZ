extends MarginContainer

const SHORTCUT_INVENTORY_ITEM = preload("res://Menus/shortcut_inventory_item.tscn")

@onready var shortcuts: GridContainer = $Panel/GridContainer2/MainHolder/InventoryPanel/ScrollContainer/Shortcuts
@onready var create_turret_popup: MarginContainer = $CreateTurretPopup
@onready var placing_buttons: GridContainer = $Panel/GridContainer2/PlacingButtons
@onready var use_slots: GridContainer = $Panel/GridContainer2/MainHolder/UseSlots

#TODO let you examine an existing turret?

func _input(event: InputEvent) -> void:

	if event.is_action_pressed("open_turret_menu"):
			## unpausing handled by the menu itself
			visible = not visible
			get_tree().paused = visible
			if visible:
				update_usable_modifiers()
	
	if event.is_action_pressed("clear"):
		for place_slot in use_slots.get_children():
			if place_slot is ShortcutInventoryItem:
				place_slot.modifier = ModifiersSingleton.empty_modifier
	
	if event.is_action_pressed("Finish attack"):
		#so that you don't have to press the button :)
		_on_create_button_pressed()

				
	# indents :)
	# Checks every input. This is very similar to input handing in player
	# Should this be placed in the singleton as a get_mod(event) -> AttackModifier??
	for modifier in ModifiersSingleton.modifier_list:
		if event.is_action_pressed(modifier.input_name):
			# TODO add modifier to list
			
			var open_slot
			#first find the first open mod slot
			for place_slot in use_slots.get_children():
				if place_slot is ShortcutInventoryItem \
					#TODO should use == empty_modifier here, but can't work since it's made local
				   and place_slot.modifier == ModifiersSingleton.empty_modifier:
					open_slot = place_slot
					break
			if open_slot:
				open_slot.modifier = modifier
			
			pass
			

func _ready():
	
	for node in placing_buttons.get_children():
		if node is TurretOrderingNode:
			node.CreateTurretAt.connect(_placing_turret_pressed)
	
	## build shortcuts menu
	#TODO could make a set ammount and make them invisible so the text doesn't keep movign.
	
	update_usable_modifiers()
	
	
	for i in range(18):
		var new_item: = SHORTCUT_INVENTORY_ITEM.instantiate()
		new_item.modifier = ModifiersSingleton.empty_modifier
		shortcuts.add_child(new_item)
	pass

func update_usable_modifiers():
	
	for child in shortcuts.get_children():
		child.modifier = ModifiersSingleton.empty_modifier
	
	## Re-create the list
	for mod in range(ModifiersSingleton.modifier_list.size()):
		if mod > shortcuts.get_child_count():
			#not sure if this actually works :P
			var new_item: = SHORTCUT_INVENTORY_ITEM.instantiate()
			new_item.modifier = ModifiersSingleton.empty_modifier
			shortcuts.add_child(new_item)
		shortcuts.get_child(mod).modifier = ModifiersSingleton.modifier_list[mod]
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
	
