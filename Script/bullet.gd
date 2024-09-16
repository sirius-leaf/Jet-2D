extends Area2D

const speed: float = 500.0

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.hp -= 1
		queue_free()
