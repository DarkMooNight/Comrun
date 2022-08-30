extends Area2D

func _on_end():
	$CollisionShape2D.position = Vector2(-100000,-100000)
