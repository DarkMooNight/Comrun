extends TextureButton

export var button = 1
onready var label = $label

func _ready():
	label.text = str(button)
