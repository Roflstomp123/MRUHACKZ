extends CharacterBody2D

#could spawn it through new, but eh.
var player_attack:PackedScene = preload("res://Player/Attacks/PlayerAttack.tscn")
@onready var projectles_parent: Node2D = $ProjectlesParent


# Not sure how to organize the modifiers.
# Just having them in a dictionary would be good, but that also makes customizability harder.
# Just moving all of that to the modifier _init, though this is not necesserally the greatest idea.


#NOTE:
#this is kept always and built as you add shortcuts
#once you fire, a projectile is created and the modifier is applied to it
#The modifier is then reset for the next projectile.
var current_modifier:AttackModifier = AttackModifier.new()

func _input(event: InputEvent) -> void:
	
	## Committing to an attack
	if event.is_action_pressed("ui_accept"):#event.is_action_pressed("Finish attack") or :
		print("Aaaaaaa")
		var new_projectile:PlayerAttack = player_attack.instantiate()
		projectles_parent.add_child(new_projectile)
		#Done since projectiles_parent is a canvas item.
		new_projectile.position = position
		
		new_projectile.apply_modifier(current_modifier)
		current_modifier.reset()
		
	if event.is_action("Enlarge attack"):
		current_modifier.size += 1 #keep in mind this is scale
		pass
	
		

func _process(delta):
	
	pass
