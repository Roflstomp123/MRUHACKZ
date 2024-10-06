extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



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

func _ready():
	var vol = randf_range(0.5, 1)
	var pitch = randf_range(1.6, 2.2)
	$AudioStreamPlayer2D.volume_db = vol
	$AudioStreamPlayer2D.pitch_scale = pitch
	$AudioStreamPlayer2D.play()
	pass

func _physics_process(delta: float) -> void:
	velocity.y = SPEED
	move_and_slide()
	if is_on_floor():
		health = 0
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
			#print("BOOM!")
			pass
			
	
	
func kill():
	animated_sprite_2d.play("Death")

func _on_animated_sprite_2d_animation_finished() -> void:
	if health <= 0:
		queue_free()




func _on_hurt_box_area_entered(area):
	health -= 1
