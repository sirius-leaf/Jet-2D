extends Control

@onready var player = $"../../Player"

func _ready():
	pass

func _process(delta):
	$playerHealthBar.value = player.hp
	$PlayerSpeedBar.value = player.currentMoveSpeed - 1000
