extends CharacterBody2D

const WALK_SPEED: int = 1000
const RUN_SPEED: int = 10000

var previousDirection: String = "right"


func update_input(delta):
	velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		velocity.x += delta * WALK_SPEED
		$AnimatedSprite2D.play("walk_right")
		previousDirection = "right"
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= delta * WALK_SPEED
		$AnimatedSprite2D.play("walk_left")
		previousDirection = "left"
	
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("lay_down")
		
	elif previousDirection == "left":
		$AnimatedSprite2D.play("idle_left")
		
	else:
		$AnimatedSprite2D.play("idle_right")
		
		
	move_and_slide()
	

func _physics_process(delta):
	update_input(delta)
	
