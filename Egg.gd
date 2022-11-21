extends Area2D

onready var timer = get_node("Timer")
onready var map = get_parent().get_parent()
onready var animation = get_node("AnimatedSprite")
func _ready():
	timer.start(rand_range(8, 10))

func _on_Timer_timeout():
	animation.playing = true



func _on_AnimatedSprite_animation_finished():
	var hatch_pos = Vector2(position.x + rand_range(-10, 10), position.y + rand_range(-10, 10))
	map.spawn_bird(hatch_pos)
	queue_free()
