extends CanvasLayer

signal start()

func _ready():
	$Control/Label.hide()
	$Control/Timer.start()

func _on_Timer_timeout():
	$Control/Label.show()

func _on_Timer1_timeout():
	$Control.visible = false
	emit_signal("start")
