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
@export var area_effect:int = 0
@export var speed:int = 0
#@export var damage:int = 0
#@export var damage:int = 0

#This is not super user fiendly, but it does allow for easy things.
#Also you can just instance it, then change the attributes normally.
#mostly just as a util
func _init(params:Dictionary = {}):
	#var temp = get_property_list()
	for arg in get_property_list():
		pass
	pass
	
func reset():
	#do this with the foor loop from init??
	damage = 0
	area_effect = 0
	speed = 0
	pass
