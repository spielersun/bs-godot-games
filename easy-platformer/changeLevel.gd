extends Area2D

export(String, FILE, "*.tscn") var level_name

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "player":
			get_tree().change_scene(level_name)
