extends Area2D

func _on_trampolin_body_entered(body):
	body.mov.y = body.jump_forse * 1.7
	SoundPlayer.play_sound(SoundPlayer.Trampolin)
	$AnimationPlayer.play("jump")
