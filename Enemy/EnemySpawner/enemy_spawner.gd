extends Node2D


"""
Works its way through the list, spawning enemies 
"""
var enemy_spawner_instructions:EnemySpawnInstructions = EnemySpawnInstructions.new()

@export var level_list:Array[EnemySpawnInstructions] = []
var level_index = 0

var current_time_to_spawn: float:
	set(val):
		current_time_to_spawn = val
		if  current_time_to_spawn <= 0:
			_spawn_next()
		pass 
var instruction_index: int = 0 
var current_instructions:SingleEnemySpawnInstruction
var _done_spawning:bool = false

@export var won_ui:WonUI:
	set(val):
		won_ui = val
		won_ui.Continue.connect(next_round)
@onready var player = $"../temp_player" 
@onready var pink = $Bigpink


func _ready():
	current_time_to_spawn = 2#enemy_spawner_instructions.spawn_instructions[0].time_offset
	level_index = -1
	pass

func _process(delta: float) -> void:
	current_time_to_spawn -= delta
	if _done_spawning:
		var temp = get_children()
		if get_children().size() == 1: #1 for the timer
			if won_ui:
				won_ui.visible = true
			pass
	pass

func next_round():
	if level_index + 1 < level_list.size():
		level_index += 1
		instruction_index = 0
		_done_spawning = false
		pass
	pass
	

func _spawn_next():
	if level_index >= 0:
		if instruction_index < level_list[level_index].spawn_instructions.size():
				
			current_instructions = level_list[level_index].spawn_instructions[instruction_index]
			
			var new_enemy = current_instructions.enemy_scene.instantiate()
			add_child(new_enemy)
			new_enemy.position = current_instructions.position
			if current_instructions.state != -1:
				#TODO fix this breaking on no state
				new_enemy.state = current_instructions.state
			
			##this is changed at the end so that it keeps the current time rather than being time for the next spawn.
			instruction_index += 1
			#double check bad :(
			if instruction_index < level_list[level_index].spawn_instructions.size():
				current_time_to_spawn = level_list[level_index].spawn_instructions[instruction_index].time_offset
			
			
			pass
		else:
			_done_spawning = true
