extends Resource
class_name AttackModifier

"""
All things are just added, not multiplied.
This makes things easier.
Could also make some multiplied, but it is easier if things only do one function
So we don't have to worry about order of operations

NOTE: Also if we change this, we have to change how apply/remove modifier works quite a bit.
"""


@export var damage:int = 0
@export var size:float = 0
@export var speed:int = 0
@export var cooldown:float = 0 #time in s to add

## things that will get added when combining two, etc.
var values_to_add:Array[String] = [
	"damage",
	"size",
	"speed",
	"cooldown"
]


@export var input_name:String = "" 


#This is not super user fiendly, but it does allow for easy things.
#Also you can just instance it, then change the attributes normally.
#mostly just as a util
func _init(params:Dictionary = {}):
	#var temp = get_property_list()
	var temp =  get_property_list()
	for arg in get_property_list():
		
		pass
	pass
		

func reset():
	#do this with the foor loop from init??
	damage = 0
	size = 0
	speed = 0
	cooldown = 0
	pass

func add(modifier:AttackModifier):
	
	"""
	Combines the modifier into this one.
	"""
	#var props:Array = get_property_list()
	for arg in get_property_list():
		
		if arg.name in values_to_add: ## MAGIC NUMBER this avoids the built in things to not cause issues.
			## This is idiotic
			if arg.name in modifier:
				_set(arg.name,_get(arg.name) + modifier._get(arg.name))
			
	pass
