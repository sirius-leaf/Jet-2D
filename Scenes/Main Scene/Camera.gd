extends Camera2D

const shakeValue: float = 24.0

@onready var player = $".."

var rng = RandomNumberGenerator.new()
var shake: Vector2
var startPos: Vector2

func _ready():
	startPos = position 
	rng.randomize()

func _physics_process(delta):
	shake = lerp(shake, Vector2(rng.randf_range(-shakeValue, shakeValue), rng.randf_range(-shakeValue, shakeValue)), 0.05 - (1.0 - player.currentMoveSpeed / 1000.0) * 0.15)
	
	position = startPos + shake
