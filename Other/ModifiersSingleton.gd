extends Node
## Can't have the same name as autoload since it hides it. This is not optimal ;_;
class_name ModifierSingleton

"""
Holds all of the modifiers for quick acess later on turrets and stuff.
Make sure to add all of the modifiers in here
"""
var max_turrets = 2
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

##List of all modifiers
#Make sure to add all of the modifiers in here
var modifier_list :Array[AttackModifier] = [
	preload("res://Player/Modifiers/increase_size.tres")#,
	#preload("res://Player/Modifiers/tracking.tres")
]

## The current list used for the turrets. Only 9 long.
var turret_modifiers:Array[AttackModifier]
var curr_mod
var modifier_file_path = "res://Player/Modifiers/"

func _ready():
	turret_modifiers.resize(9)
	turret_modifiers.fill(empty_modifier)
	pass 
