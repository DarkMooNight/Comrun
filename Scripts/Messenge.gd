extends Label

export var wt = 0.05
var timer

func on_timeout():
	set_visible_characters(get_visible_characters() + 1)
	if get_visible_characters() == get_total_character_count():
		timer.stop()
		$Timer.start()


func _on_Dialog_messege():
	timer = Timer.new()
	timer.set_wait_time(wt)
	add_child(timer)
	timer.connect("timeout", self, "on_timeout")
	timer.start()
