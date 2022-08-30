extends Control

var music_bus = AudioServer.get_bus_index("Music")

func _process(delta):
	if(AudioServer.is_bus_mute(music_bus)):
		$Off_on.pressed = true
	else:
		$Off_on.pressed = false

func _on_Off_on_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
