extends Area

export var speed = 5

func _ready():
	pass

func _process(delta):
	translation.x += speed * delta
	if translation.x >= 75:
		translation.x = -25 + speed * delta
