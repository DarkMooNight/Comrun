extends Control

onready var price = $table/Players/button/center/Price

var payment
var itemToken

var character: Dictionary = {
	0: "character_normal",
	1: "character_red",
	2: "character_chaplin",
	3: "character_night"
};

var character_int: int = 0

func _ready():
	$AnimationPlayer.play(character[character_int])

func _process(delta):
	if character_int == 0:
		if(Glob.player_dir == "res://Sprites/pc.png"):
			price.text = 'SELECTED'
		else:
			price.text = 'SELECT'
	elif character_int == 1:
		if(Glob.player_dir == "res://Sprites/pc_christmas.png") and Glob.store.bought[1] == true:
			price.text = 'SELECTED'
		elif Glob.store.bought[1] == true:
			price.text = 'SELECT'
		else:
			price.text = '100'
	elif character_int == 2:
		if(Glob.player_dir == "res://Sprites/pc_chaplin.png") and Glob.store.bought[2] == true:
			price.text = 'SELECTED'
		elif Glob.store.bought[2] == true:
			price.text = 'SELECT'
		else:
			price.text = '150'
	elif character_int == 3:
		if(Glob.player_dir == "res://Sprites/pc_night.png") and Glob.store.bought[3] == true:
			price.text = 'SELECTED'
		elif Glob.store.bought[3] == true:
			price.text = 'SELECT'
		else:
			price.text = '200'

func _on_left_pressed():
	if !character_int < 1:
		character_int -= 1
		$AnimationPlayer.play(character[character_int])

func _on_right_pressed():
	if character_int < character.size() - 1:
		character_int += 1
		$AnimationPlayer.play(character[character_int])

func _on_center_pressed():
	if character_int == 0:
		Glob.player_dir = "res://Sprites/pc.png"
	elif character_int == 1:
		buy(100, 1)
		select()
	elif character_int == 2:
		buy(150, 2)
		select1()
	elif character_int == 3:
		buy(200, 3)
		select2()
	Glob.save_game()

func _on_Back_pressed():
	get_tree().change_scene("res://Level/Menu/MeinMenu.tscn")

func buy(prise, item_no):
	if Glob.store.bought[item_no] == false:
		if Glob.coin >= prise:
			Glob.coin -= prise
			Glob.store.bought[item_no] = true

func select():
	if Glob.store.bought[1] == true:
		Glob.player_dir = "res://Sprites/pc_christmas.png"
func select1():
	if Glob.store.bought[2] == true:
		Glob.player_dir = "res://Sprites/pc_chaplin.png"
func select2():
	if Glob.store.bought[3] == true:
		Glob.player_dir = "res://Sprites/pc_night.png"


func _on_CoinPlus_pressed():
	$Yandex.load_rewarded_video()

func _on_Yandex_rewarded(currency, ammount):
	Glob.coin += 10
	Glob.save_game()

func _on_Yandex_rewarded_video_loaded():
	$Yandex.show_rewarded_video()
