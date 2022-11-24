extends Button

onready var global = get_node("res://Global.gd")
onready var new_game = preload("res://Nodes/Materials.tscn")
onready var lose_cam = get_node("../Camera2D")
onready var score_display = get_node("../Label")
onready var request_name = get_node("../RequestPlayerName")
onready var player_input = get_node("../LineEdit")
onready var header = get_node("../HighScoresHeader")
onready var high_score1 = get_node("../HighScoreList")
onready var player_score = int(var2str(get_parent().get_parent().number_of_birds))
onready var run = 0 # To temporarily fix a bug that causes manage_high_scores() to run twice, messing up the High Scores table.


class CustomSorter:
	static func sort_ascending(a, b):
		if a[0] < b[0]:
			return true
		return false

	static func sort_descending(a, b):
		if a[0] > b[0]:
			return true
		return false

func manage_high_scores(score):
	if len(Global.high_scores) > 3:
		Global.high_scores.pop_back()
	Global.high_scores.sort_custom(CustomSorter, "sort_descending")
	if player_score > Global.high_scores[2][0]:
		print(Global.high_scores)
		Global.high_scores.append([player_score, "TestPlayer"])
		print(Global.high_scores)
		Global.high_scores.sort_custom(CustomSorter, "sort_descending")
		print(Global.high_scores)
		Global.high_scores.pop_back()
		print(Global.high_scores)

func populate_high_scores():
	high_score1.text = ""
	high_score1.text += str(Global.high_scores[0][0]) + "    " + Global.high_scores[0][1] + "\n"
	high_score1.text += str(Global.high_scores[1][0]) + "    " + Global.high_scores[1][1] + "\n"
	high_score1.text += str(Global.high_scores[2][0]) + "    " + Global.high_scores[2][1]



func _ready():
	lose_cam.current = true
	score_display.text = "You had " + str(player_score) + " birds in your flock."
	header.text = "High Scores"
	manage_high_scores(player_score)
	populate_high_scores()

func _on_Button_pressed():
	get_tree().reload_current_scene()


