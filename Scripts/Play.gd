extends Control

var character: Dictionary = {
	0: "character_normal",
	1: "character_red",
	2: "character_chaplin",
	3: "character_night"
};

func _process(delta):
	if(Glob.player_dir == "res://Sprites/pc.png"):
		$AnimationPlayer.play(character[0])
	if(Glob.player_dir == "res://Sprites/pc_christmas.png"):
		$AnimationPlayer.play(character[1])
	if(Glob.player_dir == "res://Sprites/pc_chaplin.png"):
		$AnimationPlayer.play(character[2])
	if(Glob.player_dir == "res://Sprites/pc_night.png"):
		$AnimationPlayer.play(character[3])
