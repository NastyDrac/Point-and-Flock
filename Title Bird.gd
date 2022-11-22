extends KinematicBody2D
var is_moving = false
var in_area = false
var selected = false
var target = Vector2()
var speed = 100
var destination = Vector2()
onready var animate = get_node("Area2D/AnimatedSprite")
var direction
var stop_distance = 5
func _on_Title_Bird_mouse_entered():
	in_area = true
	

func _on_Title_Bird_mouse_exited():
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
		
func _physics_process(delta):
	move()
	set_destination()
	select()
	stop()


func _on_Area2D_mouse_entered():
	in_area = true


func _on_Area2D_mouse_exited():
	in_area = false
