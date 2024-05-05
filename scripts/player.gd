extends CharacterBody2D

const GRAVITY = 980.0
const SPEED = 100.0
const JUMP_VELOCITY = -350.0

func _physics_process(delta):
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
		# Slowing down base on the input
		velocity.x = dir * SPEED
	else:
		# Slowing down if there is no input
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Sprite flipping
	if Input.is_action_just_pressed('right'): $Sprite2D.flip_h = false
	if Input.is_action_just_pressed('left'): $Sprite2D.flip_h = true
	
	# Apply velocity
	move_and_slide()
