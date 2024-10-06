extends Node

"""
Holds all of the modifiers for quick acess later on turrets and stuff.
Make sure to add all of the modifiers in here
"""

@onready var player = get_tree().root.get_node("temp_player")

#Make sure to add all of the modifiers in here
var modifiers:Array[AttackModifier] = [
	preload("res://Player/Modifiers/increase_size.tres")
]
var curr_mod
var modifier_file_path = "res://Player/Modifiers/"

var turrets:Array[AttackModifier] = []

func _ready():
	turrets.resize(9)
	turrets.fill(AttackModifier.new())
	pass 
