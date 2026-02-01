extends CanvasLayer

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.play()
	timer.start()
	


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/batman.tscn")
