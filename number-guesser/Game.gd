extends Node

onready var message = $message
onready var button_correct = $correct

var guess
var min_guessed = 0
var max_guessed = 1000
var ended = false

func _ready():
	guess = (min_guessed + max_guessed) / 2
	print("-----------------------------")
	print("-----------------------------")
	print("-----------------------------")
	print("Hello from number guesser!")
	print("I'll guess any number that you think between 0 and 1000.")
	message.text = "Is " + str(guess) + " your number?"
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("up"):
		_try_guess("up")
	elif Input.is_action_just_pressed("down"):
		_try_guess("down")
	elif Input.is_action_just_pressed("space"):
		if ended:
			_restart_game()
		else:
			_end_game()
	pass

func _try_guess(type):
	if type == "up":
		min_guessed = guess
	else:
		max_guessed = guess
	guess = (min_guessed + max_guessed) / 2
	message.text = "Is " + str(guess) + " your number?"
	pass
	
func _end_game():
	ended = true
	message.text = "Yes, I knew it, your number is " + str(guess) + "!"
	button_correct.text = "Restart"
	pass

func _restart_game():
	get_tree().reload_current_scene()
	pass

func _on_greater_pressed():
	_try_guess("up")
	pass

func _on_lesser_pressed():
	_try_guess("down")
	pass

func _on_correct_pressed():
	if ended:
		_restart_game()
	else:
		_end_game()
	pass
