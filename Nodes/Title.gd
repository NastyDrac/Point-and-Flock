extends Node2D

onready var animation = $CursorAnimation
onready var bird = $KinematicBody2D
onready var cloud = preload("res://Nodes/cloud.tscn")
onready var cloud_start = get_node("WorkingTitle/cloud spawn")

export var cloud_timer = 100
var new_cloud


func _ready():
	make_clouds()
	
func _on_start_game_area_entered(area):
	get_tree().change_scene("res://Nodes/Map.tscn")


func _on_credits_area_entered(area):
	pass # Replace with function body.


func _on_Timer_timeout():
	if bird.position == Vector2(494, 329):
		animation.play("Arrow")


func _process(delta):
	cloud_timer -= 1
	if cloud_timer <= 0:
		make_clouds()
		cloud_timer = 100
		
	
	
func make_clouds():
	new_cloud = cloud.instance()
	cloud_start.add_child(new_cloud)
	new_cloud.position.y += rand_range(-250, 250)
	
	
