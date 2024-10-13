extends StaticBody2D
class_name Turret


var player_attack_scene:PackedScene = preload("res://Player/Attacks/PlayerAttack.tscn")

var sprite
var key:int = 0

const BASE_ATTACK_COOLDOWN = 0.4 ##This is bad
var turret_cooldown_multiplier = 2 #const??? #made so turrets aren't as good as the player
var cooldown:float = 0:
	set(val):
		cooldown = val
		if cooldown <= 0:
			shoot()
			cooldown = (BASE_ATTACK_COOLDOWN + modifier.cooldown) * turret_cooldown_multiplier
			pass

var modifier:AttackModifier:
	get():
		return ModifiersSingleton.turret_modifiers[key -1]

func _process(delta: float) -> void:
	cooldown -= delta

func _ready():
	modulate = ModifiersSingleton.turret_colors[key - 1]

func shoot():
	var new_attack:PlayerAttack = player_attack_scene.instantiate()
	
	#turret_p   #player      #attack_paret
	get_parent().get_parent().get_node("ProjectlesParent").add_child(new_attack)
	new_attack.position = position
	new_attack.position.y -= 40 # no const ;_;
	new_attack.apply_modifier(modifier)
	
	pass
