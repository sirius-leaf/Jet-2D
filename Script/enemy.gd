extends RigidBody2D

@export var bulletScene: PackedScene

const rotateSpeed: float = 600.0
const moveSpeed: float = 300.0

var hp: int = 10
var playerNode

func _ready():
	playerNode = $"../Player"

func _process(delta):
	if hp <= 0:
		queue_free()

func _physics_process(delta):
	var angleToPlayer: float = get_angle_to(playerNode.global_position)
	
	if angleToPlayer < 0:
		apply_torque(-1000.0)
	else:
		apply_torque(1000.0)
	
	apply_central_force(Vector2(cos(deg_to_rad(rotation_degrees)) * moveSpeed, sin(deg_to_rad(rotation_degrees)) * moveSpeed))

func _on_timer_timeout():
	if abs(rad_to_deg(get_angle_to(playerNode.global_position))) < 10.0 and global_position.distance_to($"../Player".global_position) < 120.0:
		Shoot()

func Shoot():
	var bullet = bulletScene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.transform = $Marker2D.global_transform
