extends Area2D

func _ready():
	rotation = rand_range(0, 360)

func _on_food_area_entered(area):
	if area.get_name() == "bird_body":
		get_parent().queue_free()


