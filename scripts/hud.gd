extends CanvasLayer

signal start_game

func update_coins(value):
	$MarginContainer/Coins.text = str(value)

func show_message(text):
	$Message.text = text 
	$Message.show()
	$Timer.start()

func _on_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit()
