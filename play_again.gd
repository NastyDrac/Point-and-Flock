extends Button

onready var new_game = preload("res://Nodes/Materials.tscn")
onready var lose_cam = get_node("../Camera2D")
onready var score_display = get_node("../Label")

func _ready():
	lose_cam.current = true
	score_display.text = "You had " + var2str(get_parent().get_parent().number_of_birds) + " birds in your flock."


func _on_Button_pressed():
	get_tree().reload_current_scene()
	
