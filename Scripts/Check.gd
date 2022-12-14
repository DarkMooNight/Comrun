extends Area2D

var active: bool = false

func _on_Check_body_entered(player: KinematicBody2D):
	if not active:
		if player.last_checkpoint != null:
			player.last_checkpoint.desactivate()
		player.last_checkpoint = self
		active = true

func desactivate():
	active = false
