extends Area2D

## Enemy patrol speed
@export var move_speed: float = 150.0

## Point A to patrol to
@export var patrol_point_a: Vector2 = Vector2.ZERO

## Point B to patrol to
@export var patrol_point_b: Vector2 = Vector2.ZERO

## Tolerance to snap enemy position
@export var tolerance: float = 15.0 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

## Current target point the enemy is moving towards
var current_target: Vector2


## Called when the node enters the scene tree for the first time.
func _ready():
	current_target = patrol_point_a
	$AnimatedSprite2D.play("default")

## Called every physics frame
func _physics_process(delta: float) -> void:
	# Move towards the current target
	var move_direction = (current_target - position).normalized()
	position += move_direction * move_speed * delta
	# Check if the enemy is close to the current target
	if position.distance_to(current_target) <= tolerance:
		position = current_target;
		# If at target, switch to the next target
		if current_target == patrol_point_a:
			animated_sprite.flip_h = (move_direction.x < 0)
			current_target = patrol_point_b
		else:
			current_target = patrol_point_a
			animated_sprite.flip_h = (move_direction.x < 0) 

## Called whenever a body enters the enemy
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("decrease_health"):
		body.decrease_health()
		queue_free()
