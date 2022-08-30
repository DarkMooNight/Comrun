extends HBoxContainer

onready var label: Label = $Label as Label

func _process(delta):
	label.text = str(Glob.coin)

func UpdateCoin(value):
	label.text = str(value)
