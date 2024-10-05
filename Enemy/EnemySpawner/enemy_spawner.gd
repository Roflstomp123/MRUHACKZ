extends Node2D


"""
Works its way through the list, spawning enemies 
"""
@export var enemy_spawner_instructions:Array[SingleEnemySpawnInstruction] = []#:EnemySpawnInstructions

var current_time_to_spawn: float:
	set(val):
		current_time_to_spawn = val
		if  current_time_to_spawn <= 0:
			_spawn_next()
		pass 
var instruction_index: int = 0 
var current_instructions:SingleEnemySpawnInstruction




func _ready():
	
	pass

func _process(delta: float) -> void:
	
	pass

func _spawn_next():
	instruction_index += 1
	current_instructions = enemy_spawner_instructions[instruction_index]
	
	var new_enemy = current_instructions.enemy_scene.instantiate()
	add_child(new_enemy)
	new_enemy.position = current_instructions.position
	if current_instructions.state != -1:
		#TODO fix this breaking on no state
		new_enemy.state = current_instructions.state
	
	
	
	pass
