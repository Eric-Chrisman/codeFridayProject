extends CharacterBody2D

@export var aniSprite:AnimatedSprite2D = null
@export var hurtSoundEffect:AudioStreamPlayer2D = null
@export var horraySoundEffect:AudioStreamPlayer2D = null
@export var jumpSoundEffect:AudioStreamPlayer2D = null
@export var myPosition:CollisionShape2D = null

var gravity:float = 980
var moveSpeed:float = 500
var jumpPower:float = -400
var maxJumpCount:int = 2
var jumpCount = maxJumpCount

signal playerHit
signal playerGoal

func _ready():
	if jumpSoundEffect != null:
		jumpSoundEffect.max_polyphony = jumpCount

func _process(delta):
	if not is_on_floor():
		if jumpCount == maxJumpCount:
			jumpCount = maxJumpCount - 1
		velocity.y  += gravity * delta
	else:
		jumpCount = maxJumpCount
	
	if Input.is_action_just_pressed("space") and jumpCount > 0:
		velocity.y = jumpPower
		jumpCount -= 1;
		if jumpSoundEffect != null:
			jumpSoundEffect.play()
			
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
		if hurtSoundEffect != null:
			hurtSoundEffect.play()
		emit_signal("playerHit")
		
	elif body.ID == "flag":
		if horraySoundEffect != null:
			horraySoundEffect.play()
		emit_signal("playerGoal")
