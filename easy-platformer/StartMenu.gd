extends Control

func _on_StartGameButton_pressed():
	get_tree().change_scene("res://world.tscn")

func _on_QuitGameButton_pressed():
	get_tree().quit()
