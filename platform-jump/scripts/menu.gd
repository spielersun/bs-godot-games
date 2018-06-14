extends Node

onready var highscore_text = $highscore

func _ready():
	var highscore = str($"/root/player_data".load_highscore())
	highscore_text.bbcode_text = "[center]" + highscore  + "[/center]"

func _on_Button_pressed():
	$"/root/level_manager".change_scene("game")