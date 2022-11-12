extends Area2D

onready var Egg = preload("res://Nodes/Egg.tscn")
var num_of_eggs = [1, 2, 3, 4]
onready var timer = get_node("Timer")
onready var bird = get_node("res://Nodes/bird.tscn")




func _on_Timer_timeout():
	var new_egg = Egg.instance()
	get_parent().add_child(new_egg)
	new_egg.position = position
	

func _on_Nest_area_entered(area):
	if area.get_name() == "bird_body" and area.get_parent().is_owned == true:
		timer.start()
		
	

func _on_Nest_area_exited(area):
	timer.stop()
