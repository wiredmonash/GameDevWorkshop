extends CharacterBody2D

const GRAVITY = 980.0
const SPEED = 100.0
const JUMP_VELOCITY = -350.0

@onready var sprite = $Sprite2D

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
	else:
		# Slowing down if there is no input
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
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
	pass

func decrease_health():
	health -= 1
	print('Decreased player health: ' + str(health))
	if health <= 0:
		print('YOU DIED')
		get_tree().reload_current_scene()

func increase_health():
	health += 1
	if health > 3: health = 3
	print('Increased player health: ' + str(health))
