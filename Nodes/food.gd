extends Area2D



func _on_food_area_entered(area):
	if area.get_name() == "bird_body":
		get_parent().queue_free()


