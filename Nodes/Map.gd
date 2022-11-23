extends Node2D
var max_food 
onready var timer = get_node("Timer")
onready var score_display = get_node("Label") # points to the label displaying the current score
var spawn_bird = preload("res://Nodes/bird.tscn")
export var number_of_birds = 0
var food_spawn = preload("res://Nodes/food.tscn")
onready var Egg = get_node("Nest/Egg")
onready var Nest = get_node("Nest")
onready var stuff = preload("res://Nodes/Materials.tscn")
onready var location_spawn = get_node("Spawn_location")
onready var lost_game = preload("res://Nodes/lose_screen.tscn")
var amount = 0
# var high_score = number_of_birds # Consider removing this variable as it is not called
onready var global = get_node("res://Global.gd")

func _on_Timer_timeout():
	spawn_bird(location_spawn.position)
	timer.start(60)

func _ready():
	randomize()
	spawn_material()


func count():
	number_of_birds += 1


func _process(delta):
	max_food = number_of_birds
	if amount < number_of_birds:
		spawn_food()
	score_display.text = var2str(number_of_birds)
	#print(high_scores)
	

	
func spawn_bird(place):
	var new_bird = spawn_bird.instance()
	add_child(new_bird)
	new_bird.position = place
	
	
	
func spawn_food():
	var drop_spot = Vector2(rand_range(-500, 500), rand_range(-250, 250))
	var new_food = food_spawn.instance()
	add_child(new_food)
	amount += 1
	new_food.position = drop_spot

func spawn_material():
	var material_spot = Vector2(rand_range(-500, 500), rand_range(-250, 250))
	var new_material = stuff.instance()
	add_child(new_material)
	new_material.position = material_spot
	
func _lose_game():
	var you_lose = lost_game.instance()
	add_child(you_lose)
	
