extends Area2D

onready var Egg = preload("res://Nodes/Egg.tscn")


onready var timer = get_node("Timer")
onready var bird = get_node("res://Nodes/bird.tscn")




func _on_Timer_timeout():
	
	var num_of_eggs = int(round(rand_range(1,4)))
	while num_of_eggs < 5:
		var egg_spot = position + Vector2(rand_range(-10, 10), rand_range(-10, 10))
		var new_egg = Egg.instance()
		get_parent().add_child(new_egg)
		new_egg.position = egg_spot
		num_of_eggs += 1
	

func _on_Nest_area_entered(area):
	if area.get_name() == "bird_body" and area.get_parent().is_owned == true:
		timer.start()
		
	

func _on_Nest_area_exited(area):
	timer.stop()
