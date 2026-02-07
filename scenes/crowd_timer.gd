extends Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout():
	print("test")
	#var crowd_audio_src = "res://audio/Crowd/Crowd_Bonus_0"+str(randi_range(0,9))+".wav"
	#var crowd_audio_src = "res://audio/Crowd/Crowd_Bonus_03.wav"
	#crowd.stream = load(crowd_audio_src)
	#crowd.play()
