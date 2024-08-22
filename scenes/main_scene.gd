extends Node2D

@onready var hud_: CanvasLayer = $HUD

## Called on start
func _ready() -> void:
	get_tree().paused = true
	$HUD.process_mode = Node.PROCESS_MODE_ALWAYS

## Called when the start button is pressed
func _on_hud_start_game() -> void:
	get_tree().paused = false
