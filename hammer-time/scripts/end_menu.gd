extends Node

onready var score_text = $score

var score = 0

func _ready():
	score_text.bbcode_text = "[center]" + str(score) + "[/center]"

func _on_Button_pressed():
	$"/root/level_manager".change_scene("game")
