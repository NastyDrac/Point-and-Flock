extends Button

onready var global = get_node("res://Global.gd")
onready var new_game = preload("res://Nodes/Materials.tscn")
onready var lose_cam = get_node("../Camera2D")
onready var score_display = get_node("../Label")
onready var request_name = get_node("../RequestPlayerName")
onready var player_input = get_node("../LineEdit")
onready var header = get_node("../HighScoresHeader")
onready var high_score1 = get_node("../HighScoreList")
onready var current_score = int(var2str(get_parent().get_parent().number_of_birds))


func populate_high_scores():
	high_score1.text = ""
	high_score1.text += Global.high_scores["First"][0] + "    " + str(Global.high_scores["First"][1]) + "\n"
	high_score1.text += Global.high_scores["Second"][0] + "    " + str(Global.high_scores["Second"][1]) + "\n"
	high_score1.text += Global.high_scores["Third"][0] + "    " + str(Global.high_scores["Third"][1]) + "\n"

func manage_high_scores(score):
	var first_place = Global.high_scores["First"][1]
	var second_place = Global.high_scores["Second"][1]
	var third_place = Global.high_scores["Third"][1]
	if score > third_place:
		var player_name = "TestPlayer"
		Global.high_scores.erase("Third")
		Global.high_scores["Third"] = [player_name, score]
		if score > second_place:
			Global.high_scores["Third"] = Global.high_scores["Second"]
			Global.high_scores.erase("Second")
			Global.high_scores["Second"] = [player_name, score]
			if score > first_place:
				Global.high_scores["Second"] = Global.high_scores["First"]
				Global.high_scores.erase("First")
				Global.high_scores["First"] = [player_name, score]
	populate_high_scores()

func _ready():
	lose_cam.current = true
	manage_high_scores(current_score)
	populate_high_scores()
	score_display.text = "You had " + str(current_score) + " birds in your flock."
	header.text = "High Scores"

func _on_Button_pressed():
	get_tree().reload_current_scene()


