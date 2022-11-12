extends KinematicBody2D

onready var Nest = preload("res://Nodes/Nest.tscn")
onready var animate = get_node("AnimatedSprite")
export var speed = 100
var selected = false
var is_moving = false
var in_area = false
var destination = Vector2()
var direction = Vector2()
var stop_distance = 5
var hunger_level = 10
var is_owned = false
onready var sprite = get_node("AnimatedSprite")
onready var hunger_bubble = get_node("bubble")
onready var worm = get_node("bubble/worm")
onready var mate = get_node("nest_bubble")
var randy = false
onready var nest_material = preload("res://Nodes/Nest.tscn")
var num_of_material = 0

func _on_Area2D_mouse_entered():
	in_area = true
	
func select():
	if Input.is_action_just_pressed("click") and in_area == true:
		selected = true
		
func set_destination():
	if Input.is_action_just_pressed("click") and selected == true:
		is_moving = true
		destination = get_global_mouse_position()
		selected = false
		animate.playing = true
		
func move():
	if position < destination:
		animate.flip_h = true
	if position > destination:
		animate.flip_h = false
	if is_moving == true:
		direction = destination - position
		var normalized_direction = direction.normalized()
		move_and_slide(normalized_direction * speed) 

func stop():
	if position.distance_to(destination) < stop_distance:
		is_moving = false
		animate.playing = false
		
func eat():
		hunger_level += 10
		get_parent().amount -= 1
		if is_owned == false:
			get_parent().count()
			is_owned = true
			sprite.modulate = "ffffff"

func _physics_process(delta):
	set_destination()
	become_randy()
	move()
	select()
	stop()
	crave()
	build()


func crave():
	if hunger_level < 6:
		hunger_bubble.visible = true
		worm.visible = true
	if hunger_level > 5:
		hunger_bubble.visible = false
		worm.visible = false

func _on_Area2D_mouse_exited():
	in_area = false

func _on_bird_body_area_entered(area):
	if area.get_name() == "food":
		get_parent().spawn_food()
		eat()
		
	elif area.get_name() == "Materials" and randy == true:
		gather()
		

func _on_Timer_timeout():
	hunger_level -= 1
	
func become_randy():
	if hunger_level > 15:
		randy = true
		mate.visible = true
	else:
		randy = false
		mate.visible = false
	

func gather():
	if randy == true:
		num_of_material += 1
		print(num_of_material)

func build():
	if num_of_material >= 3:
		num_of_material = 0
		var new_build = Nest.instance()
		get_parent().get_child(2).add_child(new_build)
		new_build.position = position
