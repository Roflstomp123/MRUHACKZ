extends Node2D


"""
Works its way through the list, spawning enemies 
"""
@export var enemy_spawner_instructions:EnemySpawnInstructions = EnemySpawnInstructions.new()

var current_time_to_spawn: float:
	set(val):
		current_time_to_spawn = val
		if  current_time_to_spawn <= 0:
			_spawn_next()
		pass 
var instruction_index: int = 0 
var current_instructions:SingleEnemySpawnInstruction
@onready var player = $"../temp_player" 
@onready var pink = $Bigpink


func _ready():
	current_time_to_spawn = 2#enemy_spawner_instructions.spawn_instructions[0].time_offset
	pass

func _process(delta: float) -> void:
	current_time_to_spawn -= delta
	pass

func _spawn_next():
	if instruction_index < enemy_spawner_instructions.spawn_instructions.size():
			
		current_instructions = enemy_spawner_instructions.spawn_instructions[instruction_index]
		
		var new_enemy = current_instructions.enemy_scene.instantiate()
		add_child(new_enemy)
		new_enemy.position = current_instructions.position
		if current_instructions.state != -1:
			#TODO fix this breaking on no state
			new_enemy.state = current_instructions.state
		
		##this is changed at the end so that it keeps the current time rather than being time for the next spawn.
		instruction_index += 1
		#double check bad :(
		if instruction_index < enemy_spawner_instructions.spawn_instructions.size():
			current_time_to_spawn = enemy_spawner_instructions.spawn_instructions[instruction_index].time_offset
		
		
		pass
