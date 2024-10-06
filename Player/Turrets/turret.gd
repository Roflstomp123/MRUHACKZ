extends StaticBody2D
class_name Turret


var player_attack_scene:PackedScene = preload("res://Player/Attacks/PlayerAttack.tscn")

var sprite
var key:int = 0

var turret_cooldown_multiplier = 2 #const??? #made so turrets aren't as good as the player
var cooldown:float = 0:
	set(val):
		cooldown = val
		if cooldown <= 0:
			shoot()

var modifier:AttackModifier:
	get():
		return ModifiersSingleton.modifiers[key -1]

func _process(delta: float) -> void:
	cooldown -= delta
	
func shoot():
	var new_attack = player_attack_scene.instance()
	new_attack
	cooldown = modifier.cooldown * turret_cooldown_multiplier
	pass
