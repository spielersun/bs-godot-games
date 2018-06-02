extends Area2D

export(PackedScene) var projectile
export(AudioStreamSample) var shoot_audio
export(AudioStreamSample) var explosion_audio

export var speed = 50
export var health = 30

onready var timer = $Timer
onready var collision = $CollisionShape2D
onready var audio = $audio

var dead = false
var can_shoot = true

signal was_defeated 

func _ready():
	audio.stream = shoot_audio

func _process(delta):
	if can_shoot:
		_shoot()
		
func _shoot():
	if dead:
		return
	
	var new_projectile = projectile.instance()
	new_projectile.position = global_position
	
	get_tree().get_root().add_child(new_projectile)
	
	can_shoot = false
	timer.start()
	audio.play()

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		collision.queue_free()
		hide()
		emit_signal("was_defeated")
		audio.stream = explosion_audio
		audio.play()

func _on_Timer_timeout():
	can_shoot = true
