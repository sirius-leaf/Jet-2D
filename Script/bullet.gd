extends Area2D

const speed: float = 500.0

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_timer_timeout():
	queue_free()
