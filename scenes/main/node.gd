extends Node

@export var player:CharacterBody2D = null
@onready var startingPosition:Node2D = $startingPosition

func _ready():
	print("main was loaded")
	var startingPosition:Node2D = $startingPosition
	if player and startingPosition:
		player.position = startingPosition.position
	
func _on_player_player_hit() -> void:
	if player and startingPosition:
		player.velocity = Vector2(0,0)
		player.position = startingPosition.position

func _on_win_reset() -> void:
	$CanvasLayer/win.visible = false
	_on_player_player_hit()

func _on_player_player_goal() -> void:
	$CanvasLayer/win.visible = true
