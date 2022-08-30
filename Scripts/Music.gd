extends Node

var music = preload("res://game_music/Blip Stream.mp3")
onready var mus = $Music

func play_music():
	mus.stream = music
	mus.play()
