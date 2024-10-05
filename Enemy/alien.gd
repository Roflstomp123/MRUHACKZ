extends CharacterBody2D


const SPEED = 50
var health = 2:
	set(val):
		health = val
		if health <= 0:
			kill()

var transitioning = false
var state = CIRCLE_ATTACK
## States
enum {
	MOVE_DOWN,
	MOVE_DIAGONAL,
	CIRCLE_ATTACK,
	FOLLOW_PLAYER,
	ATTACK,
}


func _physics_process(delta: float) -> void:
	
	## State selection
	
	
	match state:
		MOVE_DOWN:
			velocity.y = SPEED
			move_and_slide()
		MOVE_DIAGONAL:
			velocity.y = SPEED
			velocity.x = SPEED
			move_and_slide()
		FOLLOW_PLAYER:
			if get_parent().player:
				var player = get_parent().player
				var player_direction = global_position.direction_to(player.global_position)
				rotation = player_direction.angle()
				move_and_slide()
			pass
		CIRCLE_ATTACK:
			if !transitioning:
				transitioning = true
				var tween = create_tween()
				tween.tween_property(self, "global_position", 10, 1)
				if tween.finished:
					transitioning = false
					state = ATTACK
		ATTACK:
			print("BOOM!")
			pass
			
	
	
func kill():
	queue_free()
	


func _on_change_behaviour_timeout() -> void:
	state = randi_range(0,1)
	pass # Replace with function body.



func _on_health_area_area_entered(area: Area2D) -> void:
	#if area# is PlayerAttack:
	health -= area.damage
	pass # Replace with function body.
