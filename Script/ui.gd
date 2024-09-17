extends Control

var playerNode

func _ready():
	playerNode = $"../../Player"

func _process(delta):
	$playerHealthBar.value = playerNode.hp
	$PlayerSpeedBar.value = playerNode.currentMoveSpeed - 1000
