extends Area2D

signal TimeLife()

func _on_Battery_body_entered(body):
	if body is Player:
		body.add_life(10)
		SoundPlayer.play_sound(SoundPlayer.Hurt)
		$AnimationPlayer.play("Pick")
		yield($AnimationPlayer, "animation_finished")
		emit_signal("TimeLife")
		queue_free()
