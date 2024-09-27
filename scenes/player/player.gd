extends CharacterBody2D

@export var aniSprite:AnimatedSprite2D = null

var gravity:float = 980
var moveSpeed:float = 500
var jumpPower:float = -400

signal playerHit
signal playerGoal

func _process(delta):
	if not is_on_floor():
		velocity.y  += gravity * delta
	elif Input.is_action_just_pressed("space"):
		velocity.y = jumpPower

	
	var moveVector:float = 0
	if Input.is_action_pressed("left"):
		moveVector -= moveSpeed
		if aniSprite:
			aniSprite.play("Walk")
			aniSprite.flip_h = true
	elif Input.is_action_pressed("right"):
		moveVector += moveSpeed 
		if aniSprite:
			aniSprite.play("Walk")
			aniSprite.flip_h = false
	else:
		aniSprite.play("Idle")
	
	velocity.x = moveVector
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.ID == "hurt":
		emit_signal("playerHit")
	elif body.ID == "flag":
		emit_signal("playerGoal")
