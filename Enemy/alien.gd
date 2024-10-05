extends CharacterBody2D


const SPEED = 50
var health = 2:
	set(val):
		health = val
		if health < 0:
			kill()


var state = MOVE_DOWN
## States
enum {
	MOVE_DOWN,
	MOVE_DIAGONAL
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
			
	
	
func kill():
	queue_free()
	


func _on_change_behaviour_timeout() -> void:
	state = randi_range(0,1)
	pass # Replace with function body.



func _on_health_area_area_entered(area: Area2D) -> void:
	#if area# is PlayerAttack:
	health -= area.damage
	pass # Replace with function body.
