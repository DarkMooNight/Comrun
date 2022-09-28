extends KinematicBody2D
class_name Player

var mov = Vector2()
var speed = 85
const jump_forse = -290
var wall_jump = 120
var wall_jump_up = -330
var jump_count = 0
var wall_slide_speed = 100
var wall_slide_gravity = 50

var dead_coin = 0

var last_checkpoint: Area2D = null
onready var checkpoint: Tween = get_node("CheckPoint")

signal UpdateCoin(value)
signal UpdateLife(value)
signal Dead()
signal Check()

var portal_id = 0

var jumping = false
var mov_right = true
var on_ground = true
var is_wall_sliding = false
var death = false
var movement = false

const gravity = 20
const UP = Vector2.UP

onready var sprite = $AnimatedSprite
onready var animationPlayer = $AnimationPlayer
onready var standing_collision = $Standing
onready var croushing_collision = $Crouching
onready var collision_hurt_box = $hurtbox/hit
onready var collision_hurt_box2 = $hurtbox/chit
onready var ray1 = $r_ray/r_ray2
onready var ray2 = $r_ray/r_ray1
onready var l_head = $head/l_head
onready var r_head = $head/r_head
onready var foot : Node2D = $foot as Node2D
onready var r_ray : Node2D = $r_ray as Node2D

func _ready():
	sprite.texture = load(Glob.player_dir)

func _physics_process(delta):
	if Glob.life < 0:
		Glob.life = 0

	if Glob.life == 0:
		death = true
	elif Glob.life == 1:
		death = false

	if (ray2.is_colliding() or ray1.is_colliding()) and is_on_floor():
		mov_right = !mov_right
		scale.x = -scale.x

	var friction = false
	mov.y += gravity

	#Jump
	if Input.is_action_just_pressed("ui_up") and (!death and movement):
		if jump_count < 2 and jumping:
			SoundPlayer.play_sound(SoundPlayer.Jump)
			jump_count += 1
			_crouch(false)
			mov.y = jump_forse
			jumping = true
			on_ground = false
		elif jumping and mov.y > 0:
			jumping = false
		if friction == true:
			mov.x = lerp(mov.x, 0, 0.4)

	#WallSlide
	for ray in r_ray.get_children():
		if ray.is_colliding() and !is_on_floor():
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	if(is_wall_sliding == true):
		mov.y += (wall_slide_gravity * delta)
		mov.y = min(mov.y,wall_slide_speed)
		#WallJump
		if Input.is_action_just_pressed("ui_up") and (!death and movement):
			SoundPlayer.play_sound(SoundPlayer.Jump)
			mov.y = wall_jump_up
			mov_right = !mov_right
			scale.x = -scale.x
			mov.x = wall_jump if mov_right else -wall_jump

	#Crouch and Run
	mov.x = speed if mov_right else -speed
	if Input.is_action_pressed("ui_down") and !death and movement and is_on_floor():
		_crouch(true)
		animationPlayer.play("crouch")
	elif (l_head.is_colliding() or r_head.is_colliding()) and is_on_floor() and !death and movement:
		_crouch(true)
		jumping = false
		animationPlayer.play("crouch")
	elif death == true:
		mov.x = 0
		animationPlayer.play("death")
		yield($AnimationPlayer, "animation_finished")
		emit_signal("Dead")
		get_tree().paused = true
	elif !movement:
		animationPlayer.play("idle")
		mov.x = 0
	elif is_on_floor():
		_crouch(false)
		jumping = true
		animationPlayer.play("run")

	#OnGround and JumpBool
	if is_on_floor() or ray2.is_colliding():
		if on_ground == false:
			on_ground = true
			jump_count = 0
	else:
		if on_ground == true:
			on_ground = false
			jump_count = 1
		if mov.y < 0:
			animationPlayer.play("jump")
		else:
			animationPlayer.play("fall")
		if friction == true:
			mov.x = lerp(mov.x, 0, 0.1)

	var snap = Vector2.DOWN if !jumping else Vector2.ZERO

	mov = move_and_slide_with_snap(mov,snap,UP)
	get_enemy_raycast()
	
	for platforms in get_slide_count():
		var Body = get_slide_collision(platforms)
		if Body.collider.has_method("collide_with"):
			Body.collider.collide_with(Body, self)

#Crouch
func _crouch(crouch):
	if crouch == true:
		standing_collision.disabled = true
		croushing_collision.disabled = false
		collision_hurt_box.disabled = true
		collision_hurt_box2.disabled = false
		ray1.enabled = false
	elif crouch == false:
		standing_collision.disabled = false
		croushing_collision.disabled = true
		collision_hurt_box.disabled = false
		collision_hurt_box2.disabled = true
		ray1.enabled = true
		
#Teleport_on_off
func _on_hurtbox_area_entered(area):
	if area.is_in_group("portal"):
		if(!area.lock_portal):
			SoundPlayer.play_sound(SoundPlayer.Teleport)
			do_teleport(area)

#Damage enemy
func get_enemy_raycast():
	for ray in foot.get_children():
		var collider = ray.get_collider()
		if collider && collider.is_in_group("enemy"):
			SoundPlayer.play_sound(SoundPlayer.Hit)
			mov.y = jump_forse * 0.5
			collider.damage()

#Teleport
func do_teleport(area):
	for portal in get_tree().get_nodes_in_group("portal"):
		if portal != area:
			if portal.id == area.id:
				if(!area.lock_portal):
					area.do_lock()
					global_position = portal.global_position

#Coin
func add_coin(value):
	Glob.coin += value
	dead_coin += value
	SoundPlayer.play_sound(SoundPlayer.Coin)
	emit_signal("UpdateCoin", Glob.coin)
	Glob.save_game()

func add_life(value):
	emit_signal("UpdateLife", value)

#Checkpoint
func go_to_checkpoint():
	checkpoint.interpolate_property(self, "position", position, last_checkpoint.position, 0.4, Tween.TRANS_EXPO, Tween.EASE_OUT)
	checkpoint.start()
	movement = false
	SoundPlayer.play_sound(SoundPlayer.Teleport)
	emit_signal("Check")
	if (mov_right == false):
		mov_right = !mov_right
		scale.x = -scale.x

#Game_Over
func _on_GameOver_Continue():
	if Glob.life == 0:
		Glob.life = 1
		go_to_checkpoint()

#Start_GAme
func _on_StartRun_Run():
	movement = true

#Death
func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemy") or body.is_in_group("enemy_not_death"):
		Glob.life = 0

#Time_Death
func _on_HUD_dead():
	Glob.life = 0
	
func _on_GameOver_deadCoin():
	Glob.coin -= dead_coin
	emit_signal("UpdateCoin", Glob.coin)
	Glob.save_game()

func _on_PauseMenu_deadCoin():
	Glob.coin -= dead_coin
	emit_signal("UpdateCoin", Glob.coin)
	Glob.save_game()
