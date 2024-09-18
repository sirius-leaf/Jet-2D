extends RigidBody2D

@onready var player = $"../Player"
@onready var sprite = $PlayerPlaceholder

var hp: int = 10

func _process(delta):
	if hp <= 0:
		queue_free()
