extends "res://Script/enemy.gd"

@export var bulletScene: PackedScene

var rotateSpeed: float = 800.0
var moveSpeed: float = 300.0

func _ready():
	pass

func _process(delta):
	HealthCheck()
	
	if abs(rotation_degrees) > 90.0:
		sprite.flip_v = true
	else:
		sprite.flip_v = false

func _physics_process(delta):
	var angleToPlayer: float = get_angle_to(player.global_position)
	if moveSpeed >= 300:
		rotateSpeed = 800.0
	else:
		rotateSpeed = 300.0
	
	if angleToPlayer < 0:
		apply_torque(-rotateSpeed)
	else:
		apply_torque(rotateSpeed)
	
	apply_central_force(Vector2(cos(deg_to_rad(rotation_degrees)) * moveSpeed, sin(deg_to_rad(rotation_degrees)) * moveSpeed))

func _on_timer_timeout():
	if abs(rad_to_deg(get_angle_to(player.global_position))) < 10.0 and global_position.distance_to(player.global_position) < 150.0:
		Shoot()

func Shoot():
	var bullet = bulletScene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.transform = $Marker2D.global_transform

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		moveSpeed = 100.0

func _on_area_2d_body_exited(body):
	moveSpeed = 300.0
