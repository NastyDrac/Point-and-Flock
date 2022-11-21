extends Node2D



func _on_start_game_area_entered(area):
	get_tree().change_scene("res://Nodes/Map.tscn")


func _on_credits_area_entered(area):
	pass # Replace with function body.
