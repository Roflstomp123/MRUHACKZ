extends Node2D
class_name PlayerAttack

##NOTE: Ensure to add all these properties to all of the function!!!!!
@export var damage:int = 0
@export var area_effect:int = 0: ## This is just radius:
	set(val):
		#TODO could also just change scale, depends on wether we want to increase the sprite size as well.
		collision_shape_2d.radius = area_effect
		pass
@export var speed:int = 100

@onready var collision_shape_2d: CircleShape2D = $CollisionShape2D.shape


func _process(delta: float) -> void:
	#TODO add acceleration??
	position.y -= delta * speed
	
func _ready():
	#runs setter.
	area_effect = area_effect
	




## Modifier stuff
func apply_modifier(modifier:AttackModifier, mult:int = 1): #mult just for removing it.
	damage += modifier.damage * mult
	area_effect += modifier.area_effect * mult
	speed += modifier.speed * mult
	pass

func remove_modifier(modifier:AttackModifier):
	
	#this is easier, and I won't forget things.
	apply_modifier(modifier, -1)
