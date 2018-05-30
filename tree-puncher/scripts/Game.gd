extends Node

export(PackedScene) var trunk_scene

onready var firstTrunkPos = $firsttrunk
onready var grave = $Grave
onready var timeleft = $timeleft
onready var player = $Player
onready var timer = $Timer

var last_spawn_pos
var last_has_axe = false
var last_axe_right = false
var dead = false

var trunks = []

func _ready():
	last_spawn_pos = firstTrunkPos.position
	_spawn_first_trunks()

func _process(delta):
	if dead:
		return
	timeleft.value -= delta
	if timeleft.value <= 0:
		die()

func _spawn_first_trunks():
	for counter in range(5):
		var new_trunk = trunk_scene.instance()
		add_child(new_trunk)
		
		new_trunk.position = last_spawn_pos
		last_spawn_pos.y -= new_trunk.sprite_height
		
		new_trunk.initialize_trunk(false, false)
		trunks.append(new_trunk)

func _add_trunk(axe, axe_right):
	var new_trunk = trunk_scene.instance()
	add_child(new_trunk)
		
	new_trunk.position = last_spawn_pos
		
	new_trunk.initialize_trunk(axe, axe_right)
	trunks.append(new_trunk)

func punch_tree(from_right):	
	if !last_has_axe:
		if rand_range(0,100) > 50:
			last_axe_right = rand_range(0,100) > 50
			last_has_axe = true
		else:
			last_has_axe = false
	else:
		if rand_range(0,100) > 50:
			last_has_axe = true
		else:
			last_has_axe = false
	_add_trunk(last_has_axe, last_axe_right)
	
	trunks[0].remove(from_right)
	trunks.pop_front()
	
	for trunk in trunks:
		trunk.position.y += trunk.sprite_height
	
	timeleft.value += 0.25
	if timeleft.value > timeleft.max_value:
		timeleft.value = timeleft.max_value

func die():
	grave.position.x = player.position.x
	grave.position.y = player.position.y + 28
	player.queue_free()
	timer.start()
	grave.visible = true
	dead = true

func _on_Timer_timeout():
	get_tree().reload_current_scene()
