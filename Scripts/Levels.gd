extends Control

func _ready():
	for i in range($CenterContainer/MarginContainer/LevelsButtons.get_child_count()):
		Glob.levels.append(i+1)
		
	for level in $CenterContainer/MarginContainer/LevelsButtons.get_children():
		if str2var(level.name) in range(Glob.unlockedLevels+1):
			level.disabled = false
			level.modulate = Color(1, 1, 1)
			level.connect('pressed', self, 'change_level', [level.name])
		else:
			level.disabled = true
			level.modulate = Color(0.392157, 0.392157, 0.392157)

func _on_Back_pressed():
	get_tree().change_scene("res://Level/Menu/MeinMenu.tscn")

func change_level(lvl_no):
	if not get_tree().change_scene("res://Level/Level"+lvl_no+".tscn"):
		get_tree().change_scene("res://Level/Level"+lvl_no+".tscn")
	else:
		get_tree().change_scene("res://Level/Menu/Soon.tscn")

func _on_lvl_ad_pressed():
	get_tree().change_scene("res://Level/Menu/Levels_ad.tscn")

func _on_lvl_winter_pressed():
	get_tree().change_scene("res://Level/Menu/Levels.tscn")

func _on_lvl_green_pressed():
	get_tree().change_scene("res://Level/Menu/Levels_green.tscn")
