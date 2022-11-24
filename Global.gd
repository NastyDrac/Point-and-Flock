extends Node

var high_scores = []
onready var initial_save_filepath = "res://savedata.txt"
const savedata_filepath = "user://savedata.txt"


func _ready():
	load_high_scores()

func load_high_scores():
	var file = File.new()
	if not file.file_exists(initial_save_filepath):
		return # Future Update: Add code to create a version of res://savedata.txt
	file.open(initial_save_filepath, File.READ)
	while not file.eof_reached(): # iterate through all lines until the end of file is reached
		var first_element = int(file.get_line())
		var second_element = file.get_line()
		high_scores.append([first_element, second_element])
		if len(high_scores) > 3:
			high_scores.pop_back()
	file.close()

func save_high_score():
	var file = File.new()
	file.open(savedata_filepath, File.WRITE)
	# file for writing dictionary keys and values line by line
	file.close()
