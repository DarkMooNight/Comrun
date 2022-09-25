extends Node2D

export var dialog = true

func _ready():
	get_node("Transition_out").connect("srart", get_node("HUD/StartRun"), "_on_Transition_out_srart")
	get_node("HUD/StartRun").connect("Run", get_node("HUD"), "_on_StartRun_Run")
	get_node("HUD/StartRun").connect("Run", get_node("Player"), "_on_StartRun_Run")
	get_node("HUD/PauseMenu").connect("deadCoin", get_node("Player"), "_on_PauseMenu_deadCoin")
	get_node("HUD").connect("dead", get_node("Player"), "_on_HUD_dead")
	get_node("HUD/GameOver").connect("deadCoin", get_node("Player"), "_on_GameOver_deadCoin")
	get_node("HUD/GameOver").connect("Continue", get_node("HUD"), "_on_GameOver_Continue")
	get_node("HUD/GameOver").connect("Continue", get_node("Player"), "_on_GameOver_Continue")
	get_node("Player").connect("Check", get_node("HUD/StartRun"), "_on_Player_Check")
	get_node("Player").connect("Dead", get_node("HUD/GameOver"), "_on_Player_Dead")
	get_node("Player").connect("UpdateCoin", get_node("HUD"), "UpdateCoin")
	get_node("object/door").connect("teleport", get_node("HUD/Win"), "_on_door_teleport")
	get_node("object/perecl").connect("Is_Active", get_node("object/door"), "_on_perecl_Is_Active")
	if dialog == true:
		get_node("Dialog").connect("start", get_node("HUD"), "_on_Dialog_start")
		get_node("Dialog").connect("stop", get_node("HUD"), "_on_Dialog_stop")
		get_node("object/DialogBox").connect("body_entered", get_node("Dialog"), "_on_Dialog_body_entered")
		get_node("object/DialogBox").connect("body_exited", get_node("Dialog"), "_on_Dialog_body_exited")
		get_node("Dialog").connect("end",get_node("object/DialogBox"), "_on_end")

