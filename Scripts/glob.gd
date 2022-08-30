extends Node

var alpha
const SAVE_DIR = "user://saves/"

func _ready():
	TranslationServer.set_locale("en")
	var random = RandomNumberGenerator.new()
	random.randomize()
	var rnum = random.randi()%3 + 1
	alpha = load("res://background/Bg" + str(rnum) + ".tscn")

var levels = []
var unlockedLevels = 1
var coin = 0
var life = 1
var comleted_level = 0
var store = {
	'bought': [true, false, false, false]
}
var player_dir: String = "res://Sprites/pc.png"
var save_path = SAVE_DIR + "save.dat"

func save_game():
	var date = {
		"unlockedLevels" : unlockedLevels,
		"coin" : coin,
		"comleted_level" : comleted_level,
		"store" : store,
		"player_dir" : player_dir
	}
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "P@paB3ar6969")
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
		
	if error == OK:
		file.store_var(date)
		file.close()

func load_game():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "P@paB3ar6969")
		if error == OK:
			var player_data = file.get_var()
			unlockedLevels = player_data["unlockedLevels"]
			coin = player_data["coin"]
			comleted_level = player_data["comleted_level"]
			store = player_data["store"]
			player_dir = player_data["player_dir"]
			file.close()
