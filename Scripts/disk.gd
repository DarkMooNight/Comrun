extends Area2D

func _on_disk_body_entered(body):
	if body is Player:
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("pick")
		yield($AnimationPlayer, "animation_finished")
		queue_free()
