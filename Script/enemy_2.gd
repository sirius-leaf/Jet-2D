extends "res://Script/enemy.gd"

@onready var rayCast = $RayCast2D

@export var bulletScene: PackedScene

var moveSpeed: float = 300.0
var isColliding: bool = false

func _ready():
	pass

func _process(delta):
	var moveDirection: float = atan2(linear_velocity.y, linear_velocity.x)
	
	HealthCheck()
	
	if rayCast.is_colliding():
		moveSpeed = 50.0
	elif global_position.distance_to($"../Player".global_position) > 200.0:
		moveSpeed = 600.0
	else:
		moveSpeed = 300.0
	
	$RayCast2D.rotation = moveDirection
	$Sprite.rotation_degrees = 30.0 * (linear_velocity.x / 80.0)
	$CollisionShape2D.rotation_degrees = $Sprite.rotation_degrees

func _physics_process(delta):
	var angleToPlayer = get_angle_to(player.global_position - Vector2(0, 150.0))
	
	apply_central_force(Vector2(cos(angleToPlayer) * moveSpeed, sin(angleToPlayer) * moveSpeed))

func Shoot():
	var bullet = bulletScene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.transform = $Marker2D.global_transform

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		isColliding = true

func _on_area_2d_body_exited(body):
	isColliding = false

func _on_timer_timeout():
	if abs(rad_to_deg(get_angle_to(player.global_position) - deg_to_rad(90))) < 40.0 and global_position.distance_to(player.global_position) < 150.0:
		$Marker2D.look_at($"../Player".global_position)
		Shoot()
