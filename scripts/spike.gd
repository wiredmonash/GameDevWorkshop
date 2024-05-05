extends Area2D

func _on_body_entered(body):
	if body.get_name() == 'Player':
		body.decrease_health()
		self.queue_free()
