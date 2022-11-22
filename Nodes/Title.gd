extends Node2D

onready var animation = $CursorAnimation
onready var bird = $Bird

func _on_start_game_area_entered(area):
	get_tree().change_scene("res://Nodes/Map.tscn")


func _on_credits_area_entered(area):
	pass # Replace with function body.


func _on_Timer_timeout():
	if bird.position == Vector2(494, 329):
		animation.play("Arrow")
