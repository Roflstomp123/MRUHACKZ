extends Node2D


"""
Works its way through the list, spawning enemies 
"""
var enemy_spawner_instructions:EnemySpawnInstructions = EnemySpawnInstructions.new()

@export var level_list:Array[EnemySpawnInstructions] = []
var level_index = 0

@export var test:Array[Array]

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
	#will move the level_index to 0 to start with the first level.
	#next_round()
	
	#needed?
	#await get_tree().process_frame
	#make a black cover to stop the flash on first frame?
	won_ui.set_level_text(level_list[0].level_descriptor)
	pass

func _process(delta: float) -> void:
	current_time_to_spawn -= delta
	if _done_spawning:
		var temp = get_children()
		if get_children().size() == 1: #1 for the timer
			if won_ui and player.health_current > 0:
				won_ui.visible = true
			pass
	pass

## Called on start and on continue button press 
## move to the setter -><-
func next_round():
	
	if level_index + 1 < level_list.size():
		level_index += 1
		print("Current round = ", level_index)
		instruction_index = 0
		_done_spawning = false
		pass
		
		
		
		ModifiersSingleton.modifier_list.append_array(level_list[level_index].new_unlocks)
		
		## This is called on button press for the next one,
		## so we do need to load in the text of the next level
		if level_index + 1 < level_list.size():
			won_ui.set_level_text(level_list[level_index + 1].level_descriptor)
		
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
