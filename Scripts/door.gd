extends Area2D

signal teleport()
export var lvl = 0

func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			SoundPlayer.play_sound(SoundPlayer.Door)
			emit_signal("teleport")
			get_tree().paused = !get_tree().paused
			
func _on_perecl_Is_Active():
	$AnimationPlayer.play("opening")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("opened")


func _on_door_body_entered(body):
	if body.name == "Player" and Glob.comleted_level == lvl:
		Glob.unlockedLevels += 1
		Glob.comleted_level +=1
	Glob.save_game()
