extends Node2D

onready var arrow = $Arrow
var arrow_speed = 130

func _process(delta):
	arrow.translate(Vector2.LEFT * arrow_speed * delta)

func _on_Area2D_body_entered(body):
	if body == arrow:
		$StaticBody2D/Sprite.play("idle")
		arrow.global_position = $StaticBody2D/Sprite/Position2D.global_position
