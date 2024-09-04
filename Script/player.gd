extends RigidBody2D

const moveSpeed: float = 1000.0
const rotateSpeed: float = 1000.0

@onready var sprite = $Sprite2D

func _ready():
	pass

func _process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		apply_torque(rotateSpeed * direction)
	
	if rotation_degrees < -90.0 or rotation_degrees > 90.0:
		sprite.flip_v = true
	else:
		sprite.flip_v = false

func _physics_process(delta):
	apply_central_force(Vector2(cos(deg_to_rad(rotation_degrees)) * moveSpeed, sin(deg_to_rad(rotation_degrees)) * moveSpeed))
