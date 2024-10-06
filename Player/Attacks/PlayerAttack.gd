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

var tracking:bool = false
var target:Area2D




func _process(delta: float) -> void:
	if tracking:
		#var temp = (position.x - possible_targets[closest_index].position.x)
		var direction:Vector2 = Vector2(1, -1).normalized()
		if is_instance_valid(target):
			if position.x > target.global_position.x:
				direction.x *= -1
						
			if abs(position.x - target.global_position.x) < 5:
				position.y -= delta * speed
			else:
				position += direction * delta * speed
			#region bad
		## Should make a targetting function so I don't do this every frame
		# bad >:(
		## Targetting
		#var closest_distance = 2000
		#var closest_index = -1
		#if possible_targets.size() > 0:
		#	for target in range(possible_targets.size()):
		#		#death checking
		#		if possible_targets[target] != null:
		#			if position.distance_to(possible_targets[target].position) < closest_distance:
		#				## I like indents :D
		#				closest_index = target
		#				pass
		#			pass
		#	
		#	if possible_targets[closest_index] != null:
		#		var temp = (position.x - possible_targets[closest_index].position.x)
		#		
		#		var direction:Vector2 = Vector2(1, -1).normalized()
		#		if position.x > possible_targets[closest_index].position.x:
		#			direction.x *= -1
		#		position += direction * delta * speed
		#	else:
		#		position.y -= delta * speed
		#else:
		#	position.y -= delta * speed
		#pass
		#endregion
		else:
			position.y -= delta * speed
	else:
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
	
	tracking = tracking or modifier.tracking
	pass

## This is never used
func remove_modifier(modifier:AttackModifier):
	apply_modifier(modifier, -1)
	tracking = false


func _on_tracking_detector_area_entered(area: Area2D) -> void:
	if target == null:
		target = area
	pass # Replace with function body.
