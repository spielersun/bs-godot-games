extends Area

onready var animation = $animation

var already_hit = false 

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_area_entered(area):
	if area.name == "hammer" and !already_hit:
		animation.play("hit")
