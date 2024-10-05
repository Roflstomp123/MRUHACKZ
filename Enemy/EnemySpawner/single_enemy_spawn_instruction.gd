extends Resource
class_name SingleEnemySpawnInstruction

@export var position:Vector2 = Vector2.ZERO
@export var enemy_scene:PackedScene = EnemySingleton.simple_alien
## Not sure the best way to do this, currently, this will be the time from the last enemy to this one.
@export var time_offset:float = 0 #in seconds
@export var state:int = -1 #-1 will not do anything. Consult enemy enum to see what should states there are. ##NOTE: This is horrible, sry :(
