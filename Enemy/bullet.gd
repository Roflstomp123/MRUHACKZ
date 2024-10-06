extends Area2D

var speed = 600

func _process(delta):
	var direction = -Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	pass
