extends Area2D

export var impulse = 100
onready var animation = $animation

var height 

func _ready():
	height = animation.frames.get_frame("idle", 0).get_height()
	connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	if body.name == "player" and body.position.y < position.y and !body.jumping:
		body.add_impulse(impulse)
		animation.play("spring")