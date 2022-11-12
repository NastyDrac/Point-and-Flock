extends Area2D

signal gathering


func _on_Materials_area_entered(area):
	get_parent().spawn_material()
	queue_free()
