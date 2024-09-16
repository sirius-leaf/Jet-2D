extends RigidBody2D

signal dead

const rotateSpeed: float = 600.0
const moveSpeed: float = 300.0

var hp: int = 10

func _ready():
	pass

func _process(delta):
	if hp <= 0:
		dead.emit()
		queue_free()

func _physics_process(delta):
	var angleToPlayer: float = get_angle_to($"../Player".global_position)
	
	if angleToPlayer < 0:
		apply_torque(-1000.0)
	else:
		apply_torque(1000.0)
	
	apply_central_force(Vector2(cos(deg_to_rad(rotation_degrees)) * moveSpeed, sin(deg_to_rad(rotation_degrees)) * moveSpeed))
