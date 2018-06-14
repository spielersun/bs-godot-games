extends Area2D

onready var sprite = $Sprite

const SPRING_CHANCE = 10

var spring_path = "res://scenes/spring.tscn"
var sprite_half_width

func _ready():
	randomize()
	connect("body_entered", self, "_on_body_entered")
	sprite_half_width = (sprite.texture.get_size().x) / (2 * scale.x)
	
	if rand_range(0,100) > (100 - SPRING_CHANCE):
		var new_spring = load(spring_path).instance()
		add_child(new_spring)
		new_spring.position = Vector2(0, -new_spring.height)
		
func _on_body_entered(body):
	if body.name == "player":
		if body.position.y < position.y:
			body.jump()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
