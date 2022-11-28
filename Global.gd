extends Node

var number_of_birds : int = 0
var player_name : String = ""
var high_scores = []
onready var initial_save_filepath = "res://savedata.txt"
const savedata_filepath = "user://savedata.txt"


func _ready():
	load_high_scores()

func load_high_scores():
	var file = File.new()
	if not file.file_exists(initial_save_filepath):
		return # Future Update: Add code to create a version of res://savedata.txt
	if file.file_exists(savedata_filepath):
		file.open(savedata_filepath, File.READ)
		while not file.eof_reached(): # iterate through all lines until the end of file is reached
			var first_element = int(file.get_line())
			var second_element = file.get_line()
			high_scores.append([first_element, second_element])
			while len(high_scores) > 3:
				high_scores.pop_back() # remove blank lines at end of file
	else:
		file.open(initial_save_filepath, File.READ)
		while not file.eof_reached(): # iterate through all lines until the end of file is reached
			var first_element = int(file.get_line())
			var second_element = file.get_line()
			high_scores.append([first_element, second_element])
			while len(high_scores) > 3:
				high_scores.pop_back() # remove blank lines at end of file
	file.close()

func save_high_scores():
	var file = File.new()
	file.open(savedata_filepath, File.WRITE)
	for list in range(3):
		for item in range(2):
			file.store_string(str(high_scores[list][item]) + "\n")
	file.close()
