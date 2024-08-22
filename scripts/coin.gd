extends Area2D

## Pickup functionality
func pickup():
	# Disables collisions
	$CollisionShape2D.set_deferred("disabled", true)
	# Little tween for animating scale
	var tw = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD)
	tw.tween_property(self, "scale", scale * 3, 0.3)
	tw.tween_property(self, "modulate:a", 0.0, 0.3)
	# wait for tween to finish then delete coin
	await tw.finished
	queue_free()

## Called when a body enters the coins area
func _on_body_entered(body: Node2D):
	if body.has_method("increase_coin_count"):
		body.increase_coin_count()
		pickup()
