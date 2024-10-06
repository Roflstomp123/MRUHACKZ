extends Area2D

var speed = 600

func _process(delta):
	var direction = -Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	pass
	if abs(position.x)  > 1500 or abs(position.y) > 1300:
		queue_free()
