extends Area2D

signal Is_Active

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$AnimationPlayer.play("Active")
			emit_signal("Is_Active")
			SoundPlayer.play_sound(SoundPlayer.Percel)
			$CollisionShape2D.disabled = true
		else:
			$AnimationPlayer.play("Idle")
