extends Node

onready var mus = $Music
var random
var rnumMusic
var finish = false
var beta

func genety():
	random = RandomNumberGenerator.new()
	random.randomize()
	rnumMusic = random.randi_range(1, 6)
	beta = load("res://game_music/music/" + str(rnumMusic) + ".mp3")

func _ready():
	genety()

func play_music():
	mus.stream = beta
	mus.play()

func _process(delta):
	if(finish == true):
		genety()
		finish = false
		play_music()

func _on_Music_finished():
	finish = true
