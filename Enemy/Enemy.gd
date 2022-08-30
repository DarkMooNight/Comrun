extends KinematicBody2D
class_name Enemy

const FLOOR_NORMAL : = Vector2(0, -1)

var gravity : = 10
export var speed : = 70
var velocity : = Vector2()
var target_speed : = 0
export var direction = -1
export var povorot = true
export var mov = true

onready var animated_sprite : Sprite = $Sprite as Sprite

var ray = null
var ray_b = null

func _ready():
	if(mov == true):
		ray = $l_ray
		ray_b = $b_ray

func _process(delt):
	if velocity.x < 0:
		animated_sprite.flip_h = false
	elif velocity.x > 0:
		animated_sprite.flip_h = true

func _physics_process(delta):
	velocity.x = lerp(velocity.x, target_speed, .4)
	if abs(velocity.x) < 1:
		velocity.x = 0
	
	var snap : = Vector2.DOWN * 8
	velocity = move_and_slide_with_snap(velocity, snap, FLOOR_NORMAL)

func apply_gravity():
		velocity.y = velocity.y + gravity

func get_inputs():
	if ray.is_colliding() or not ray_b.is_colliding() and povorot:
		ray.cast_to.x *= -1
		direction = direction * -1
		ray_b.position.x = $CollisionShape2D.shape.get_extents().x * direction
	target_speed = sign(ray.cast_to.x) * speed
	
func damage():
	$AnimationPlayer.play("death")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

func dvig():
	ray_b.enabled = povorot
	ray_b.position.x = $CollisionShape2D.shape.get_extents().x * direction
