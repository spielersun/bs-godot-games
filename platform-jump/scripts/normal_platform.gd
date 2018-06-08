extends Area2D

onready var sprite = $Sprite
var sprite_half_width

func _ready():
	connect("body_entered", self, "_on_body_entered")
	sprite_half_width = (sprite.texture.get_size().x) / (2 * scale.x)

func _on_body_entered(body):
	if body.name == "player":
		if body.position.y < position.y:
			body.jump()
