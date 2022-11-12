extends Area2D


onready var map = get_parent().get_parent()



func _on_Timer_timeout():
	var hatch_pos = Vector2(position.x + rand_range(-10, 10), position.y + rand_range(-10, 10))
	map.spawn_bird(hatch_pos)
	queue_free()

