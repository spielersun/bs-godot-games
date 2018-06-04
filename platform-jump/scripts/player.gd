extends KinematicBody2D

onready var animated_sprite = $AnimatedSprite

const GRAVITY = 1500
const GRAVITY_INCREMENT = 2500 
const JUMP_INCREMENT = 100

var screen_width
var half_sprite_width

var jumping = false
var current_jump_force = 0
var current_gravity = 0

func _ready():
	screen_width = get_viewport_rect().size.x
	half_sprite_width = animated_sprite.frames.get_frame("idle", 0).get_width() / 2
	current_gravity = GRAVITY
