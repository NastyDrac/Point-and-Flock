extends Node2D

onready var timer = get_node("Timer")
onready var score = get_node("Label")
var spawn_bird = preload("res://Nodes/bird.tscn")
export var number_of_birds = 0
var food_spawn = preload("res://Nodes/food.tscn")
onready var food_timer = get_node("food_timer")
onready var Egg = get_node("Nest/Egg")
onready var Nest = get_node("Nest")
func _on_Timer_timeout():
	spawn_bird(position)
	timer.stop()

func _ready():
	randomize()
	
func _on_food_timer_timeout():
	spawn_food()

func count():
	number_of_birds += 1


func _process(delta):
	
	score.text = var2str(number_of_birds)
	
	
func spawn_bird(place):
	var new_bird = spawn_bird.instance()
	add_child(new_bird)
	new_bird.position = place
	
	
func spawn_food():
	var drop_spot = Vector2(rand_range(-500, 500), rand_range(-250, 250))
	var new_food = food_spawn.instance()
	add_child(new_food)
	new_food.position = drop_spot
	food_timer.wait_time = 1
	print(drop_spot)
