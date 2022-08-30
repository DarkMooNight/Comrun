extends CanvasLayer

signal stop()
signal start()
signal messege()
signal end()

export var messeng: String

func _ready():
	$NinePatchRect.visible = false
	$NinePatchRect/Messenge.hide()
	$NinePatchRect/Messenge.text = messeng

func _on_Dialog_body_entered(body):
	if body is Player:
		body.movement = false
		emit_signal("stop")
		$NinePatchRect.visible = true
		$NinePatchRect/Timer.start()
		emit_signal("messege")
		$Timer.start()

func _on_Dialog_body_exited(body):
	if body is Player:
		body.movement = true
		$NinePatchRect.visible = false
		emit_signal("start")

func _on_Timer_timeout():
	$NinePatchRect/Messenge.show()

func _on_end_timer():
	emit_signal("end")
