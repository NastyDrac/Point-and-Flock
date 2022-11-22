extends KinematicBody2D

# INITIAL VARIABLES
# References to other scenes
onready var Nest = preload("res://Nodes/Nest.tscn")
onready var nest_material = preload("res://Nodes/Nest.tscn")
# References to sprites
onready var body = get_node("bird_body")
onready var animate = get_node("AnimatedSprite")
onready var sprite = get_node("AnimatedSprite")
onready var hunger_bubble = get_node("bubble")
onready var worm = get_node("bubble/worm")
onready var mate = get_node("nest_bubble")
# Bird parameters/attributes
export var speed = 100
var selected = false
var is_moving = false
var in_area = false
var destination = Vector2()
var direction = Vector2()
var stop_distance = 5
var hunger_level = 10
var is_owned = false
var randy = false
var num_of_material = 0


# AUDIO CENTER
# References to sounds/samples
onready var squawk = get_node("HungrySquawk02")
onready var whistle = get_node("HelloThereWhistle02")
# "Anti-looping" variables
var has_squawked = false
var has_whistled = false
# Playback function
func play_sound(AudioStream_object):        # Mandatory argument requires pointer to AudioStreamPlayer object (squawk, whistle, etc.)
	if AudioStream_object.playing == false:
		AudioStream_object.play()
func _ready():
	animate.self_modulate = "ffef00"
	squawk.pitch_scale = rand_range(.9,1.5)
	whistle.pitch_scale = rand_range(.9,1.5)
# "OWNED" BIRD FUNCTIONS
# ... for selecting and moving birds
func _on_Area2D_mouse_entered(): # Detects mouse on bird
	in_area = true

func _on_Area2D_mouse_exited(): # Detects mouse off bird
	in_area = false

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
		animate.flip_h = false
	if position > destination:
		animate.flip_h = true
	if is_moving == true:
		direction = destination - position
		var normalized_direction = direction.normalized()
		move_and_slide(normalized_direction * speed) 

func stop():
	if position.distance_to(destination) < stop_distance:
		is_moving = false
		animate.playing = false
		animate.frame = 0


# ... for managing "owned" bird states (hungry, randy, etc.)
func crave():
	if hunger_level < 6:
		hunger_bubble.visible = true
		worm.visible = true
		animate.self_modulate = "ff4949"
		if has_squawked == false:
			play_sound(squawk)
			has_squawked = true
	if hunger_level > 5:
		hunger_bubble.visible = false
		worm.visible = false

func become_randy():
	if hunger_level > 15:
		randy = true
		mate.visible = true
		if has_whistled == false:
			play_sound(whistle)
			has_whistled = true
			
	else:
		randy = false
		mate.visible = false


# ... for eating and and nesting
func eat():
		
		hunger_level += 10
		get_parent().amount -= 1
		if is_owned == false:
			get_parent().count()
			is_owned = true
			sprite.self_modulate = "ffffff"

func gather():
	if randy == true:
		num_of_material += 1
		print(num_of_material)

func build():
	if num_of_material >= 2:
		num_of_material = 0
		var new_build = Nest.instance()
		get_parent().get_child(2).add_child(new_build)
		new_build.position = position

func _on_bird_body_area_entered(area): # Eats food or gathers nest materials
	if area.get_name() == "food":
		get_parent().spawn_food()
		eat()
	elif area.get_name() == "Materials" and randy == true:
		gather()


# GENERAL GAME FUNCTIONS
# ... for making "non-owned" birds leave if too hungry
func leave_flock():
	if hunger_level <= 0:
		animate.playing = true
		is_moving = true
		destination = Vector2(600, 400)
		move()
		if position.x >= 550 and hunger_level <= 0:
			queue_free()
	if position.x >= 550 and hunger_level > 0:
		destination = Vector2(rand_range(-400, 400), rand_range(-250, 250))
		is_moving = true
		animate.playing = true

# ... for managing timer-based state changes (every three seconds)
func _on_Timer_timeout():
	# Birds get hungrier
	hunger_level -= 1
	# Reset sounds to be played again next time play_sound() is called
	has_squawked = false 
	has_whistled = false 

func bird_death():
	if hunger_level <= 0 and is_owned == true:
		get_parent()._lose_game()

func _physics_process(delta):
	set_destination()
	become_randy()
	move()
	select()
	crave()
	build()
	bird_death()
	leave_flock()
	stop()
	if is_owned == true and hunger_level > 5:
		animate.self_modulate = "ffffff"
	if animate.flip_h == true and mate.visible == true:
		mate.flip_h = false
	else: 
		mate.flip_h = true

	if animate.flip_h == true and hunger_bubble.visible == true:
		hunger_bubble.flip_h = false
	else:
		hunger_bubble.flip_h = true
