extends CharacterBody2D

const GRAVITY = 980.0
const SPEED = 100.0
const JUMP_VELOCITY = -350.0

@onready var sprite = $AnimatedSprite2D 
@onready var stream_player = $AudioStreamPlayer2D

@onready var powerup_snd = load('res://sounds/powerup.wav')
@onready var ouch_snd = load('res://sounds/ouch.mp3')
@onready var death_snd = load('res://sounds/death.mp3')

var health : int = 3
var max_health : int = health

func _ready():
	""" 
	This function is called by the engine when the node first 
	enters the SceneTree
	"""
	print('Player health: ' + str(health))

func _physics_process(delta):
	""" 
	This function is called by the engine every before every 
	physics step.
	"""
	# A force of gravity on the player
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	# Get inputs
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('jump')
	
	# Jumping
	if jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Movement 
	var dir = int(right) - int(left)
	if dir:
		# Adding velocity with direction and speed
		velocity.x = dir * SPEED
		sprite.play('run')
	else:
		# Slowing down if there is no input
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play('idle')
	
	# Sprite flipping
	if Input.is_action_just_pressed('right'): sprite.flip_h = false
	if Input.is_action_just_pressed('left'): sprite.flip_h = true
	
	# Apply velocity
	move_and_slide()

func _process(_delta):
	""" 
	This function is called by the engine every frame (dependent
	on your machine).
	"""
	if Input.is_action_just_pressed('close_game'):
		get_tree().quit()
		
	if Input.is_action_just_pressed('restart_game'):
		get_tree().reload_current_scene()

func decrease_health():
	health -= 1
	print('Decreased player health: ' + str(health))
	stream_player.stream = ouch_snd
	stream_player.play()
	if health <= 0:
		print('YOU DIED')
		stream_player.stream = death_snd
		stream_player.play()
		await stream_player.finished
		get_tree().reload_current_scene()

func increase_health():
	health += 1
	if health > 3: health = 3
	stream_player.stream = powerup_snd
	stream_player.play()
	print('Increased player health: ' + str(health))
