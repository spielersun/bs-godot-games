extends KinematicBody2D

onready var animated_sprite = $AnimatedSprite
onready var audio = $audio

const JUMP_AUDIO_PATH = "res://audio/jump.wav"
const IMPULSE_AUDIO_PATH = "res://audio/impulse.wav"
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
var highest_reached_pos = 300
var death_pos_offset = 1200
var score = 0
var jump_audio
var impulse_audio

signal just_jumped

func _ready():
	score = int(abs(highest_reached_pos) - 300)
	screen_width = get_viewport_rect().size.x
	half_sprite_width = animated_sprite.frames.get_frame("idle", 0).get_width() / 2
	current_gravity = GRAVITY
	
	jump_audio = load(JUMP_AUDIO_PATH)
	impulse_audio = load(IMPULSE_AUDIO_PATH)

func _process(delta):
	if !jumping:
		_increment_gravity(delta)
		position.y += current_gravity * delta
	else:
		position.y -= current_jump_force
		_decrement_gravity(delta)
	
	highest_reached_pos = position.y if position.y < highest_reached_pos else highest_reached_pos
	score = int(abs(highest_reached_pos) - 300)
	score = score if score > 0 else 0
	
	if position.y >= highest_reached_pos + death_pos_offset:
		die()
	
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	elif Input.is_action_pressed("ui_accept"):
		jump()
	
	_check_boundaries()

func jump():
	if jumping:
		return
	
	current_gravity = 0
	jumping = true
	current_jump_force = JUMP_FORCE
	
	animated_sprite.play("jump")
	emit_signal("just_jumped")
	
	audio.stream = jump_audio
	audio.play()

func add_impulse(impulse):
	emit_signal("just_jumped")
	
	current_gravity = 0
	jumping = true
	current_jump_force = impulse
	animated_sprite.play("jump")
	
	audio.stream = impulse_audio
	audio.play()

func die():
	$"/root/player_data".save_highscore(score)
	$"/root/level_manager".change_scene("menu")

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

func _check_boundaries():
	if position.x > screen_width:
		position.x = 0
	elif position.x < 0:
		position.x = screen_width
