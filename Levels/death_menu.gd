extends Control
@onready var audio_stream_player = $AudioStreamPlayer
@onready var texture_rect: TextureRect = $TextureRect


var playing = false
func _process(delta):
	
	if visible == true && !playing:
		audio_stream_player.play()
		playing = true
	elif visible == true:
		## max is one second.
		texture_rect.modulate.a += delta /2 
		pass
	else:
		playing = false
		audio_stream_player.stop()

func _on_main_menu_pressed():
	GameManager.change_scene("Menu")
	pass

func _on_play_again_pressed():
	get_tree().reload_current_scene()
