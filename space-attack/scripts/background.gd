extends Node2D

const MOVE_SPEED = 200
const OFFSET = 64

onready var top = $topbg
onready var bottom = $bottombg

var top_pos
var bottom_pos

func _ready():
	top_pos = top.position.y
	bottom_pos = get_viewport_rect().size.y

func _process(delta):
	top.position.y += MOVE_SPEED * delta
	bottom.position.y += MOVE_SPEED * delta
	
	if top.position.y >= bottom_pos + OFFSET:
		top.position.y = top_pos
	elif bottom.position.y >= bottom_pos + OFFSET:
		bottom.position.y = top_pos