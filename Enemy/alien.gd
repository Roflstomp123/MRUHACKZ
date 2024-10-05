extends CharacterBody2D
var Alienattack:PackedScene = preload("res://Enemy/alien.tscn")

const SPEED = 50


func _physics_process(delta: float) -> void:
	velocity.y = SPEED
	move_and_slide()



func kill():
	queue_free()
	
	
func shoot():
	pass
	
	
	
	
	
