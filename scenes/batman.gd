extends Node2D

@onready var audio = $audio
@onready var crowd = $crowd
@onready var timer = $timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#GameState.get_hero_sound()
	#audio.stream = load(GameState.intro_hero_sound_src)
	var batman_intro_src = "res://audio/Batman/Batman_02.wav"
	audio.stream = load(batman_intro_src)
	audio.play()
	timer.wait_time = 5
	timer.one_shot = false # Set to true if it should only run once
	timer.connect("timeout", _on_shoot_timer_timeout)
	timer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_shoot_timer_timeout():
	var crowd_audio_src = "res://audio/Crowd/Crowd_Batman_"+str(randi_range(1,22))+".wav"
	crowd.stream = load(crowd_audio_src)
	crowd.play()
