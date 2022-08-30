extends Control

signal Continue()

signal deadCoin()

func _on_Restart_pressed():
	emit_signal("deadCoin")
	get_tree().paused = false
	Glob.life = 1
	get_tree().reload_current_scene()

func _on_MainMenu_pressed():
	emit_signal("deadCoin")
	Glob.life = 1
	get_tree().change_scene("res://Level/Menu/MeinMenu.tscn")
	get_tree().paused = false

func _on_Exit_pressed():
	emit_signal("deadCoin")
	get_tree().quit()

func _on_Player_Dead():
	SoundPlayer.play_sound(SoundPlayer.Death)
	$".".visible = true

func _on_Continue_pressed():
	$VBoxContainer/Button.visible = false
	$SureYesNo.visible = true

func _on_NoContinue_pressed():
	$VBoxContainer/Button.visible = true
	$SureYesNo.visible = false

func _on_Coins_pressed():
	if Glob.coin >= 20:
		Glob.coin -= 20
		$VBoxContainer/Button.visible = true
		$SureYesNo.visible = false
		$".".visible = false
		emit_signal("Continue")
		Glob.life = 1
		get_tree().paused = false
		Glob.save_game()

func _on_Yandex_rewarded_video_loaded():
	$Yandex.show_rewarded_video()

func _on_Yandex_rewarded(currency, ammount):
	$VBoxContainer/Button.visible = true
	$SureYesNo.visible = false
	$".".visible = false
	emit_signal("Continue")
	Glob.life = 1
	get_tree().paused = false
	Glob.save_game()

func _on_Ads_pressed():
	$Yandex.load_rewarded_video()
