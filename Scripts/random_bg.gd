extends Control

func _ready():
	var alphainstance = Glob.alpha.instance()
	add_child(alphainstance)
