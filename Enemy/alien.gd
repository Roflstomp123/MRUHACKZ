extends CharacterBody2D


const SPEED = 50


func _physics_process(delta: float) -> void:
	velocity.y = SPEED
	move_and_slide()
	
	
	
func kill():
	queue_free()
	
