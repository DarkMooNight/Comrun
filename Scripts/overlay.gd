extends ColorRect

var progress = 0.0

func _process(delta):
	material.set("shader_param/progress", progress)

