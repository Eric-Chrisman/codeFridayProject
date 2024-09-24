extends Camera2D

@export var player:CharacterBody2D

func _process(_delta):
	if player:
		position = player.position
