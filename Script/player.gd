extends RigidBody2D

@export var bulletScene: PackedScene

const moveSpeed: float = 1000.0
const rotateSpeed: float = 1000.0
const rngBulletRotation: float = 3.0

@onready var sprite = $Sprite2D

var rng = RandomNumberGenerator.new()
var currentMoveSpeed: float = 1000.0
var targetEnemy
var enemyInScene = []
var hp: int = 15

func _ready():
	rng.randomize()
	enemyInScene = get_tree().get_nodes_in_group("Enemy")
	if not enemyInScene.is_empty():
		SelectEnemy()

func _process(delta):
	# rotate player
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		apply_torque(rotateSpeed * direction)
	
	# player speed control
	if Input.is_key_pressed(KEY_Z):
		currentMoveSpeed = clamp(currentMoveSpeed + 500.0 * delta, 1000.0, 2000.0)
	else:
		currentMoveSpeed = clamp(currentMoveSpeed - 1000.0 * delta, 1000.0, 2000.0)
	
	if abs(rotation_degrees) > 90.0:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	
	# target nearest enemy
	if targetEnemy != null:
		var enemyPos = targetEnemy.global_position
		var angleToEnemy = abs(rad_to_deg(get_angle_to(enemyPos)))
		var enemyPointerAlpha: float = 1.0
		var distanceToEnemy = global_position.distance_to(enemyPos)
		
		$EnemyDirection.look_at(enemyPos)
		$EnemyDirection/Node2D/Label.text = str(roundi(distanceToEnemy))
		
		if distanceToEnemy > 200:
			enemyPointerAlpha = 0.3
		else:
			enemyPointerAlpha = 1.0
		
		if angleToEnemy < 20.0:
			$Marker2D.look_at(enemyPos)
			$EnemyDirection/Bullet.modulate = Color("red", enemyPointerAlpha)
		else:
			$EnemyDirection/Bullet.modulate = Color("white", enemyPointerAlpha)
			$Marker2D.rotation_degrees = 0
	else:
		enemyInScene = get_tree().get_nodes_in_group("Enemy")
		if not enemyInScene.is_empty():
			SelectEnemy()
		else:
			$EnemyDirection.rotation_degrees = 0
	

func _physics_process(delta):
	apply_central_force(Vector2(cos(deg_to_rad(rotation_degrees)) * currentMoveSpeed, sin(deg_to_rad(rotation_degrees)) * currentMoveSpeed))

func _on_timer_timeout():
	if Input.is_action_pressed("ui_accept"):
		Shoot()

func Shoot():
	var bullet = bulletScene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.transform = $Marker2D.global_transform
	bullet.rotation_degrees += rng.randf_range(-rngBulletRotation, rngBulletRotation)

func SelectEnemy():
	var enemyDistance = []
	
	for enemy in enemyInScene:
		enemyDistance.append(global_position.distance_to(enemy.global_position))
	
	var enemyIndex = enemyDistance.find(enemyDistance.min())
	targetEnemy = enemyInScene[enemyIndex]
