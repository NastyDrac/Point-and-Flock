extends Button

onready var new_game = preload("res://Nodes/Materials.tscn")
onready var lose_cam = get_node("../Camera2D")


func _ready():
	lose_cam.current = true

func _on_Button_pressed():
	get_tree().reload_current_scene()
	
