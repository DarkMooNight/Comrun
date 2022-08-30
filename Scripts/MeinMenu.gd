extends Control

func _ready():
	Glob.load_game()

func _on_Exit_pressed():
	get_tree().quit()

func _on_StartGame_pressed():
	get_tree().change_scene("res://Level/Menu/Levels.tscn")

func _on_Store_pressed():
	get_tree().change_scene("res://Level/Menu/Store.tscn")

func _on_close_pressed():
	$Internet.visible = false
	$Internet2.visible = false

func _on_Ru_pressed():
	TranslationServer.set_locale("ru")

func _on_En_pressed():
	TranslationServer.set_locale("en")
