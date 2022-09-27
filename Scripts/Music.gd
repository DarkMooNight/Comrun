extends Node

onready var mus = $Music
var beta

func play_music():
	random_music()
	mus.stream = beta
	mus.play()

func _on_Music_finished():
	play_music()

func random_music():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var rnumMusic = random.randi_range(1, 6)
	beta = load("res://game_music/music/" + str(rnumMusic) + ".mp3")
