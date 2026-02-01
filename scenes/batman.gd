extends Node2D

@onready var audio = $audio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.get_hero_sound()
	audio.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
