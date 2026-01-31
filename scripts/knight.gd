extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var coins_label: Label = $coins_label
var coins: int = 0


func add_coin() -> void:
	coins += 1
	coins_label.text = str(coins) + "/5"



@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var double_jump_available = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		double_jump_available = true
		
	else:
		velocity += get_gravity() * delta

		if Input.is_action_just_pressed("jump") and double_jump_available:
			velocity.y = JUMP_VELOCITY
			double_jump_available = false
			
			
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		double_jump_available = true
		

	
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
		
	elif direction < 0:
		animated_sprite.flip_h = true

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
			
		else:
			animated_sprite.play("run")
			
	else:
		animated_sprite.play("jump")
		
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
