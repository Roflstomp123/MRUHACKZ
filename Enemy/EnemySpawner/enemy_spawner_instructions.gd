extends Resource
class_name EnemySpawnInstructions
"""
I recomment saving these as individual resources
then add them into the enemy spawner to avoid the
possibility of these getting randomly deleted.
"""
var enemy_scenes:Dictionary = {
	
}

@export var level_name:String = ""
## The text that will be shown when the level is about to start.
@export_multiline var level_descriptor = ""

## These are unlocked at the start of this level
@export var new_unlocks:Array[AttackModifier] = [] 
@export var spawn_instructions:Array[SingleEnemySpawnInstruction] = []


func add_spawn_instruction(enemy_scene_name:String, position:float, behaviour:int):
	#will add it to the list. 
	pass
