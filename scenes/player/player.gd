extends CharacterBody2D

var gravity:float = 980
var moveSpeed:float = 500
var jumpPower:float = -400

func _process(delta):
	if not is_on_floor():
		velocity.y  += gravity * delta
	elif Input.is_action_just_pressed("space"):
		velocity.y = jumpPower

	
	var moveVector:float = 0
	if Input.is_action_pressed("left"):
		moveVector -= moveSpeed 
	if Input.is_action_pressed("right"):
		moveVector += moveSpeed 
	
	velocity.x = moveVector
	move_and_slide()


func _on_area_2d_body_entered(body):
	print("OW")
