extends Area

onready var animation = $animation

var already_hit = false 

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

func _on_area_entered(area):
	if area.name == "hammer" and !already_hit:
		animation.play("hit")
		already_hit = true
