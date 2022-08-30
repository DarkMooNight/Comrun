extends Control

export(String, FILE, "*.tscn") var world_scene

func _on_Continue_pressed():
	$".".visible = false
	get_tree().paused = false
	get_tree().change_scene(world_scene)
	Glob.save_game()

func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	Glob.save_game()

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Level/Menu/MeinMenu.tscn")
	get_tree().paused = false
	Glob.save_game()

func _on_Exit_pressed():
	get_tree().quit()
	Glob.save_game()

func _on_door_teleport():
	$".".visible = true
