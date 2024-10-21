extends Resource
class_name AttackModifier

"""
All things are just added, not multiplied.
This makes things easier.
Could also make some multiplied, but it is easier if things only do one function
So we don't have to worry about order of operations

NOTE: Also if we change this, we have to change how apply/remove modifier works quite a bit.
"""


@export var damage:float = 0
@export var size:float = 0
@export var speed:float = 0
@export var cooldown:float = 0 #time in s to add
@export var tracking:bool = false

## things that will get added when combining two, etc.
var values_to_add:Array[String] = [
	"damage",
	"size",
	"speed",
	"cooldown",
	"heal_ammount"
]

@export var input_name:String = "" 

@export_category("One time effects")
## Heal by this much on press. Have to balance this for turrets??
## Starting max is 100. 0 won't heal ofc.
@export var heal_ammount:int = 0

const CANNON:Texture2D = preload("res://Assets/cannon_single_white.png")

#This is not super user fiendly, but it does allow for easy things.
#Also you can just instance it, then change the attributes normally.
#mostly just as a util
func _init(params:Dictionary = {}):
	#var temp = get_property_list()
	var temp =  get_property_list()
	for arg in get_property_list():
		
		pass
	pass
		

# Only ever called on current_modifier in player.gd 
func reset():
	#do this with the foor loop from init??
	damage = 0
	size = 0
	speed = 0
	cooldown = 0
	heal_ammount = 0
	tracking = false
	pass

func add(modifier:AttackModifier):
	
	"""
	Combines the modifier into this one.
	"""
	
	tracking = tracking or modifier.tracking
	
	#var props:Array = get_property_list()
	var temp = get_property_list()
	for arg in get_property_list():
		
		if arg.name in values_to_add: ## MAGIC NUMBER this avoids the built in things to not cause issues.
			## This is idiotic
			if arg.name in modifier:
				set(arg.name,get(arg.name) + modifier.get(arg.name))
			
	pass

# Used for some things??? (descriptive, ik, ik).
# healing, etc. Not sure if it's actually useful.
# How does this work with a turret??
# Remember that this is always called on current_modifier,
# so it will have the addition of what was pressed.
func one_time_effect(player):
	player.health_current += heal_ammount
	if player.health_current > player.health_max:
		player.health_current = player.health_max
