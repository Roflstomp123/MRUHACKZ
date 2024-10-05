extends CharacterBody2D

#could spawn it through new, but eh.
var player_attack:PackedScene = preload("res://Player/Attacks/PlayerAttack.tscn")
@onready var projectles_parent: Node2D = $ProjectlesParent
@onready var make_turret_menu: MarginContainer = $CanvasLayer/MakeTurretMenu



# Not sure how to organize the modifiers.
# Just having them in a dictionary would be good, but that also makes customizability harder.
# Just moving all of that to the modifier _init, though this is not necesserally the greatest idea.

## Attack
var attack_cooldown:float = 0 #in secconds
var attack_cooldown_max:float = 0.2
#NOTE:
#this is kept always and built as you add shortcuts
#once you fire, a projectile is created and the modifier is applied to it
#The modifier is then reset for the next projectile.
var current_modifier:AttackModifier = AttackModifier.new()

## Attack Modifiers #export?
var size_increase_modifier:float = 0.4 #scale of projectile
var speed_increase_modifier:float = 100 #pixels/second ??

## Movement
var move_direction:Vector2
var move_speed:float = 400


func _input(event: InputEvent) -> void:
	
	## Movement handled inside of process because that's eaiser.
	
	## Committing to an attack
	if event.is_action_pressed("Finish attack") and attack_cooldown < 0:
		var new_projectile:PlayerAttack = player_attack.instantiate()
		projectles_parent.add_child(new_projectile)
		#Done since projectiles_parent is a canvas item.
		new_projectile.position = position
		
		new_projectile.apply_modifier(current_modifier)
		current_modifier.reset()
		
		attack_cooldown = attack_cooldown_max
		
		
		
	## Handling modifiers 
	# Make sure to only use values that are vars at the top so it's easier to iterate.
	if event.is_action("Enlarge attack"):
		current_modifier.size += size_increase_modifier
		pass
	#if event.is_action("multi attack")
	
	if event.is_action_pressed("open_turret_menu"):
		#TODO pausing?
		#also this shouldn't be here, it should be done after missions.
		make_turret_menu.visible = not make_turret_menu.visible
		

func _process(delta):
	## Movement 
	move_direction.x = Input.get_axis("Move left", "Move right")
	velocity = move_direction * move_speed #no mult by delta  since move_and_slide should handle that.
	move_and_slide()
	
	## Attack
	attack_cooldown -= delta
	
	pass
