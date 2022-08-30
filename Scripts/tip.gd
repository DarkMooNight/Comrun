tool
extends Area2D

enum {IDLE, RUN}
var acao = IDLE

signal run()

func _on_tip_body_entered(body):
	acao = RUN
	if acao == RUN:
		emit_signal("run")
	acao = IDLE
	$Timer.start()
	if body is Player:
		body.movement = false

func _on_tip_body_exited(body):
	if body is Player:
		body.movement = true

func _on_Timer_timeout():
	$CollisionShape2D.position = Vector2(-100000,-100000)
