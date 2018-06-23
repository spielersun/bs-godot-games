extends Area

onready var animation = $animation

signal nail_hit
signal game_end
 
var is_nail_hit = false

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

func _input(event):
	if (event is InputEventMouseButton or InputEventScreenTouch) and event.is_pressed():
		animation.play("hit")

func _on_area_entered(area):
	if area.is_in_group("Nails"):
		if area.already_hit:
			emit_signal("game_end")
			return
			
		is_nail_hit = true
		area.already_hit = true
		emit_signal("nail_hit")
		
func check_nail_hit():
	if !is_nail_hit:
		emit_signal("game_end")
	
	is_nail_hit = false