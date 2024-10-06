extends Node2D
class_name PlayerAttack

##NOTE: Ensure to add all these properties to all of the function!!!!!
@export var damage:float = 1

##NOTE: this being scale means that you have to set the texture to the proper size. This will be a bit tough, sry.
	## Could change to an independent sprite_size and size
@export var size:float = 1: ## This is just scale ### This is just radius:
	set(val):
		#TODO could do radius instead to not mess with the pixel sizing, but eh. 
		#That's also tough and would require having a ton of sprites.
		#Prob not worth it
		
		
		#this is dumb??
		size = val
		scale = Vector2(size,size)
		#collisdoion_shape_2d.radius = size
		pass
@export var speed:float = 400
@export var cooldown:float = 0.2 #in seconds

@onready var collision_shape_2d: CircleShape2D = $CollisionShape2D.shape


func _process(delta: float) -> void:
	#TODO add acceleration??
	position.y -= delta * speed
	
func _ready():
	#runs setter.
	size = size

## Modifier stuff
func apply_modifier(modifier:AttackModifier, mult:int = 1): #mult just for removing it.
	damage += modifier.damage * mult
	size += modifier.size * mult
	speed += modifier.speed * mult
	cooldown += modifier.cooldown
	pass

func remove_modifier(modifier:AttackModifier):
	apply_modifier(modifier, -1)
