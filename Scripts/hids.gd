extends Node2D

onready var label = $tip/tip_content/Label
export var hids: String

func _ready():
	label.text = hids
