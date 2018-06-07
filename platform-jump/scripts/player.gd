extends KinematicBody2D

onready var animated_sprite = $AnimatedSprite

const GRAVITY = 1500
const GRAVITY_INCREMENT = 2500 
const JUMP_DECREMENT = 100
const JUMP_FORCE = 40

export var speed = 500

var screen_width
var half_sprite_width

var jumping = false
var current_jump_force = 0
var current_gravity = 0

func _ready():
	screen_width = get_viewport_rect().size.x
	half_sprite_width = animated_sprite.frames.get_frame("idle", 0).get_width() / 2
	current_gravity = GRAVITY

func _process(delta):
	if !jumping:
		_increment_gravity(delta)
		position.y += current_gravity * delta
	else:
		position.y -= current_jump_force
		_decrement_gravity(delta)
		
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	elif Input.is_action_pressed("ui_accept"):
		jump()

func jump():
	if jumping:
		return
	
	current_gravity = 0
	jumping = true
	current_jump_force = JUMP_FORCE
	
	animated_sprite.play("jump")

func _increment_gravity(delta):
	current_gravity += GRAVITY_INCREMENT * delta
	if current_gravity >= GRAVITY:
		current_gravity = GRAVITY

func _decrement_gravity(delta):
	current_jump_force -= JUMP_DECREMENT * delta
	if current_jump_force <= 0:
		current_jump_force = 0
		jumping = false
		animated_sprite.play("idle")