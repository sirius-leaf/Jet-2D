extends RigidBody2D

@onready var player = $"../Player"
@onready var sprite = $Sprite

@export var hp: int = 10

func _process(delta):
	print("aa")

func HealthCheck():
	if hp <= 0:
		queue_free()
