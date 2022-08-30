extends Node

const Jump = preload("res://game_music/Jump.wav")
const Coin = preload("res://game_music/Coin.wav")
const Death = preload("res://game_music/Death.wav")
const Hurt = preload("res://game_music/Heart Beat.wav")
const Hit = preload("res://game_music/Hit.wav")
const Teleport = preload("res://game_music/Teleport.wav")
const Start = preload("res://game_music/Balloon Pop 1.wav")
const Trampolin = preload("res://game_music/Simple Jump 003.wav")
const Percel = preload("res://game_music/Start run.wav")
const Door = preload("res://game_music/PP_23.wav")

onready var audioPlayers = $AudioPlayers

func play_sound(sound):
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
