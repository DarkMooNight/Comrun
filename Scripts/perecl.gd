extends Area2D

signal Is_Active
signal dialogActive

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$AnimationPlayer.play("Active")
			emit_signal("Is_Active")
			emit_signal("dialogActive")
			SoundPlayer.play_sound(SoundPlayer.Percel)
			$CollisionShape2D.disabled = true
		else:
			$AnimationPlayer.play("Idle")
