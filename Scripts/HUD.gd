extends CanvasLayer

signal Coin(value)
signal max_changed(new_max)
signal changed(new_amount)

signal dead()

export(int) var max_amount = 10 setget set_max
onready var current = max_amount setget set_current
onready var time_life = $Control/MarginContainer/HBoxContainer/VBoxContainer/Helth/Life

var time = false

func UpdateCoin(value):
	emit_signal("Coin", value)

func _on_TextureButton_pressed():
	get_tree().paused = !get_tree().paused
	$PauseMenu.visible = true

func _on_Timer_timeout():
	if time == true:
		time_life.value -=1
		if time_life.value == 0:
			SoundPlayer.play_sound(SoundPlayer.Death)
			$GameOver.visible = true
			get_tree().paused = !get_tree().paused
			emit_signal("dead")

func _ready():
	_initialize()

func set_max(new_max):
	max_amount = new_max
	max_amount = max(1,new_max)
	emit_signal("max_changed",max_amount)
	
func set_current(new_value):
	current = new_value
	current = clamp(current,0,max_amount)
	emit_signal("changed",current)
	
	if current == 0:
		emit_signal("depleted")
		
func _initialize():
	emit_signal("max_changed", max_amount)
	emit_signal("changed",current)

func _on_GameOver_Continue():
	time_life.value = max_amount

func _on_Battery_TimeLife():
	time_life.value += 10

func _on_StartRun_Run():
	time = true

func _on_Dialog_start():
	time = true

func _on_Dialog_stop():
		time = false

