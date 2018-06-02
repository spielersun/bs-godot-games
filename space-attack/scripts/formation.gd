extends Node2D

export var speed = 100

var target_pos
var left_bound
var right_bound
var is_in_pos = false
var direction = 1
var enemies_count

signal formation_defeated

func _ready():
	target_pos = rand_range(200, get_viewport_rect().size.y / 2)
	left_bound = position.x - 100
	right_bound = position.x + 100
	
	direction = 1 if rand_range(0,100) > 50 else -1 
	enemies_count = get_children().size()

func _process(delta):
	movement(delta)
	position.x += speed * direction * delta
	
	if position.x > right_bound:
		direction = -1
	elif position.x < left_bound:
		direction = 1

func movement(delta):
	if is_in_pos:
		return
	
	position.y += speed * delta
	if position.y >= target_pos:
		position.y = target_pos
		is_in_pos = true 

func _defeated():
	emit_signal("formation_defeated")
	queue_free()

func _on_enemy_was_defeated():
	enemies_count -= 1
	if enemies_count == 0:
		_defeated()
