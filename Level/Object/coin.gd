extends Area2D

func _on_coin_body_entered(body):
	if body is Player:
		body.add_coin(1)
		$AnimationPlayer.play("pick")
		yield($AnimationPlayer, "animation_finished")
		queue_free()
