extends Area

onready var animation = $animation

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if (event is InputEventMouseButton or InputEventScreenTouch) and event.is_pressed():
		animation.play("hit")

func _on_area_entered(area):
	pass
