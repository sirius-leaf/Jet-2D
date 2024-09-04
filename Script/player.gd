extends RigidBody2D

@export var bulletScene: PackedScene

const moveSpeed: float = 1000.0
const rotateSpeed: float = 1000.0
const rngBulletRotation: float = 3.0

@onready var sprite = $Sprite2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		apply_torque(rotateSpeed * direction)
	
	if rotation_degrees < -90.0 or rotation_degrees > 90.0:
		sprite.flip_v = true
		$Marker2D.position.y = -8
	else:
		sprite.flip_v = false
		$Marker2D.position.y = 8

func _physics_process(delta):
	apply_central_force(Vector2(cos(deg_to_rad(rotation_degrees)) * moveSpeed, sin(deg_to_rad(rotation_degrees)) * moveSpeed))

func _on_timer_timeout():
	if Input.is_action_pressed("ui_accept"):
		Shoot()

func Shoot():
	var bullet = bulletScene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.transform = $Marker2D.global_transform
	bullet.rotation_degrees += rng.randf_range(-rngBulletRotation, rngBulletRotation)
