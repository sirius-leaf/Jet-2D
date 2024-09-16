extends Area2D

const speed: float = 250.0

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	pass
