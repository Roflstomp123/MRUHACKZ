extends CharacterBody2D

#could spawn it through new, but eh.
var player_attack:PackedScene = preload("res://Player/Attacks/PlayerAttack.tscn")
@onready var projectles_parent: Node2D = $ProjectlesParent
@onready var make_turret_menu: MarginContainer = $CanvasLayer/MakeTurretMenu

const TURRET = preload("res://Player/Turrets/turret.tscn")
@onready var turrent_parent: Node2D = $TurrentParent

const TURRET_POSITION_OFFSET = 100
@export var deathmenu: Control
@onready var turret_catching_area: Area2D = $TurretCatchingArea

# Not sure how to organize the modifiers.
# Just having them in a dictionary would be good, but that also makes customizability harder.
# Just moving all of that to the modifier _init, though this is not necesserally the greatest idea.


var random_strength = 10.0
var shake_fade = 5.0
var shake_strength = 0.0

## Health
var health_max = 100
var health_current = 50

## Attack
var attack_cooldown:float = 0 #in secconds
var attack_cooldown_max:float = 0.4
#NOTE:
#this is kept always and built as you add shortcuts
#once you fire, a projectile is created and the modifier is applied to it
#The modifier is then reset for the next projectile.
var current_modifier:AttackModifier = AttackModifier.new()

## Attack Modifiers #export?
var size_increase_modifier:float = 0.4 #scale of projectile
var speed_increase_modifier:float = 100 #pixels/second ??

## Movement
var move_direction:Vector2
var move_speed:float = 400


func _toggle_turret_monitoring():
	turret_catching_area.monitoring = true
	turret_catching_area.monitorable = true
	# This sucks, heheh
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	turret_catching_area.monitoring = false
	turret_catching_area.monitorable = false

func _input(event: InputEvent) -> void:
	
	## Movement handled inside of process because that's eaiser.
	## Committing to an attack
	if event.is_action("Finish attack") and attack_cooldown < 0:
		var new_projectile:PlayerAttack = player_attack.instantiate()
		projectles_parent.add_child(new_projectile)
		var pew_chance = randf()
		if pew_chance < 0.01:
			$AudioStreamPlayer2D.play()
		else:
			var vol = randf_range(0.5, 2)
			var pitch = randf_range(0.5, 1)
			$AudioStreamPlayer2D2.volume_db = vol
			$AudioStreamPlayer2D2.pitch_scale = pitch
			$AudioStreamPlayer2D2.play()
		#Done since projectiles_parent is a canvas item.
		new_projectile.position = position
		
		new_projectile.apply_modifier(current_modifier)
		current_modifier.reset()
		
		attack_cooldown = attack_cooldown_max
		
		
	## Handling modifiers 
	# Make sure to only use values that are vars at the top so it's easier to iterate.
	if event.is_action("Enlarge attack"):
		current_modifier.size += size_increase_modifier
		pass
	#if event.is_action("multi attack")
	
	if event.is_action_pressed("open_turret_menu"):
		#TODO pausing?
		#also this shouldn't be here, it should be done after missions.
		make_turret_menu.visible = not make_turret_menu.visible
		
	
	## Turret moving
	if event.is_action_pressed("remove_turret"):
		_toggle_turret_monitoring()
		
	
	## Turret spawning
	for input_str in ModifiersSingleton.turret_inputs:
		if ModifiersSingleton.turret_modifiers[int(input_str) -1].input_name != "empty_modifier" and event.is_action_pressed(input_str):
			if turrent_parent.get_children().size() < ModifiersSingleton.max_turrets:
				var new_turret:Turret = TURRET.instantiate()
				turrent_parent.add_child(new_turret)
				new_turret.key = int(input_str)
				
				new_turret.position = position
				new_turret.position.y -= TURRET_POSITION_OFFSET
			
			
			pass
			

func _process(delta):
	## Movement 
	move_direction.x = Input.get_axis("Move left", "Move right")
	move_direction.y = Input.get_axis("Move up", "Move down")
	velocity = move_direction * move_speed #no mult by delta  since move_and_slide should handle that.
	if velocity.x > 0:
		$AnimatedSprite2D.scale.x = -5
	elif velocity.x < 0:
		$AnimatedSprite2D.scale.x = 5
	move_and_slide()
	
	## Attack
	attack_cooldown -= delta

	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shake_fade * delta)
		$Camera2D.offset = random_offset()
	pass


func take_damage(damage):
	health_current -= 100
	apply_shake()
	if health_current <= 0:
		$AnimationPlayer.play("byebye")
	else:
		$owTimer.start()
		$AnimatedSprite2D.play("ow")
		$AudioStreamPlayer2D3.play()
	pass

func _on_ow_timer_timeout():
	$AnimatedSprite2D.play("hewwo")
	pass 

func _on_area_2d_area_entered(area):
	take_damage(10)


func _on_turret_catching_area_body_entered(body: Node2D) -> void:
	if body is Turret:
		body.queue_free()
func after_death():
	deathmenu.visible = true
	set_process_mode(4)
	print("dead")
	pass 


func apply_shake():
	shake_strength = random_strength
	
func random_offset():
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
