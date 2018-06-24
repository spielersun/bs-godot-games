extends Area

onready var animation = $animation
onready var audio = $audio

var already_hit = false 

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

func _on_area_entered(area):
	if area.name == "hammer" and !already_hit:
		audio.play()
		animation.play("hit")


func _on_VisibilityNotifier_camera_exited(camera):
	if !already_hit:
		$"/root/game".load_end_game(score)

func end_game():
	$"/root/game".load_end_game(score)