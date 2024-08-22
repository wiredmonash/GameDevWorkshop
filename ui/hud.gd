extends CanvasLayer

signal start_game

## References to GUI nodes
@onready var title: Label = $Title
@onready var margin_container: MarginContainer = $MarginContainer
@onready var coin_count: Label = $MarginContainer/CoinCount
@onready var margin_container_2: MarginContainer = $MarginContainer2
@onready var start_button: Button = $MarginContainer2/StartButton

## Updates the current coin count in UI
func update_coin_count(value: int):
	coin_count.text = str(value)
	
## Hide UI and start game
func _on_start_button_pressed() -> void:
	title.visible = false
	margin_container_2.visible = false
	## Emit a signal telling any listeners, the game is ready to play
	start_game.emit()
