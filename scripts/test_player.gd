extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var coins_label: Label = $Camera2D/coins_label
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $timer
@onready var audio: AudioStreamPlayer = $audio

var coins: int = 0
var dead: bool = false
var double_jump_available = true
var active_mask = GameState.current_mask

func add_coin() -> void:
	coins += 1
	coins_label.text = str(coins) + "/5"

func kill() -> void:
	timer.start()
	dead = true
	animated_sprite.play(get_anim("death"))
	audio.stream = load(GameState.death_hero_sound_src)
	audio.play()

func get_anim(base_name: String) -> String:
	match active_mask.type:
		MaskData.MaskType.THIEF:
			return "thief_" + base_name
		MaskData.MaskType.ANGEL:
			return "angel_" + base_name
		MaskData.MaskType.CYCLOPS:
			return "cyclops_" + base_name
	return base_name

func _physics_process(delta: float) -> void:
	if dead:
		return
					
	velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		double_jump_available = true

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
		
	elif direction < 0:
		animated_sprite.flip_h = true


	animated_sprite.play("batman_jump")
		
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://menus/maskmenu/mask_selection.tscn")
