extends Control

signal deadCoin()

func _on_Continue_pressed():
	get_tree().paused = false
	$".".visible = false

func _on_MainMenu_pressed():
	emit_signal("deadCoin")
	get_tree().change_scene("res://Level/Menu/MeinMenu.tscn")
	get_tree().paused = false

func _on_Exit_pressed():
	emit_signal("deadCoin")
	get_tree().quit()

func _on_Restart_pressed():
	emit_signal("deadCoin")
	get_tree().paused = false
	get_tree().reload_current_scene()
