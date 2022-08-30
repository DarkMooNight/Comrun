extends Node2D

signal run()

func _ready():
	hide()
	get_parent().connect("run", self, "on_run")

func on_run():
	emit_signal("run")
	show()
