extends Control
@onready var audio_stream_player = $AudioStreamPlayer
var playing = false
func _process(delta):
	if visible == true && !playing:
		audio_stream_player.play()
		playing = true
	elif visible == true:
		pass
	else:
		playing = false
		audio_stream_player.stop()

func _on_main_menu_pressed():
	Gamemanager.change_scene("Menu")
	pass

func _on_play_again_pressed():
	get_tree().reload_current_scene()
