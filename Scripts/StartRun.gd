extends Control

signal Run()

func _on_Button_pressed():
	$".".visible = false
	SoundPlayer.play_sound(SoundPlayer.Start)
	emit_signal("Run")

func _on_Player_Check():
	$".".visible = true

func _on_Transition_out_srart():
	$".".visible = true

func _on_Histore_start():
		$".".visible = true
