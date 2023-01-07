extends Control

func _ready():
	Glob.load_game()
	$YandexAds.load_banner()

func _on_Exit_pressed():
	get_tree().quit()

func _on_StartGame_pressed():
	get_tree().change_scene("res://Level/Menu/Levels.tscn")
	$YandexAds.hide_banner()

func _on_Store_pressed():
	get_tree().change_scene("res://Level/Menu/Store.tscn")
	$YandexAds.hide_banner()

func _on_close_pressed():
	$Internet.visible = false
	$Internet2.visible = false

func _on_Ru_pressed():
	TranslationServer.set_locale("ru")

func _on_En_pressed():
	TranslationServer.set_locale("en")

func _on_vk_pressed():
	OS.shell_open('https://vk.com/darkmoonight')

func _on_discord_pressed():
	OS.shell_open('https://discord.com/invite/JMMa9aHh8f')

func _on_telegram_pressed():
	OS.shell_open('https://t.me/+bXvLJdzO2pZiZGVi')

func _on_YandexAds_banner_loaded():
	$YandexAds.show_banner()
