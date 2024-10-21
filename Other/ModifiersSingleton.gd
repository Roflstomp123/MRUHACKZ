extends Node
## Can't have the same name as autoload since it hides it. This is not optimal ;_;

"""
Holds all of the modifiers for quick acess later on turrets and stuff.
Make sure to add all of the modifiers in here
"""
var max_turrets:int = 2
var turret:PackedScene = preload("res://Player/Turrets/turret.tscn")
@onready var player = get_tree().root.get_node("temp_player")
var empty_modifier = preload("res://Player/Modifiers/empty_modifier.tres")


@onready var turret_inputs:Array[String] = [
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9"
]


enum MODIFIER_TYPES{
	INCREASE_SIZE,
	TRACKING
}
##List of all modifiers
#Make sure to add all of the modifiers in here
var modifier_list :Array[AttackModifier] = []

## The current list used for the turrets. Only 9 long.
## Make into a dictionary/object??
var turret_modifiers:Array[AttackModifier]
#NOTE: Colors will not update when updating turret stuff.
#could fix this easily with a signal and stuff, but eh.
var turret_colors:Array[Color]
var curr_mod

func _ready():
	turret_modifiers.resize(9)
	turret_modifiers.fill(empty_modifier)
	turret_colors.resize(9)
	turret_colors.fill(Color.WHITE)
	
	# TODO REMOVE, ONLY USED FOR TESTING
	await get_tree().process_frame
	modifier_list.append(preload("res://Player/Modifiers/heal.tres"))
	pass 
