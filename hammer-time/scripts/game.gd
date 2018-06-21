extends Node

onready var score_text = $score

var score = 0

func _ready():
	score_text.text = str(score)

func _on_hammer_nail_hit():
	score += 1
	score_text.text = str(score)

func _on_hammer_game_end():
	$"/root/level_manager".load_end_game(score)
