extends Area2D

onready var sprite = $Sprite
onready var collision = $collision
onready var particles = $particles

var sprite_half_width

func _ready():
	sprite_half_width = (sprite.texture.get_size().x) / (2 * scale.x)
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.name == "player" and !body.jumping:
		if body.position.y < position.y:
			body.jump()
			sprite.queue_free()
			collision.queue_free()
			particles.emitting = true