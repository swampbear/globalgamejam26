extends CanvasLayer

@onready var story_text = $StoryText
@onready var continue_hint = $ContinueHint

var is_done = false

func _ready():
	story_text.visible_characters = 0
	
	var total = story_text.get_total_character_count()
	var tween = create_tween()
	tween.tween_property(story_text, "visible_characters", total, total / 30.0)
	tween.tween_callback(_on_done)

func _on_done():
	is_done = true
	var tween = create_tween()
	tween.tween_property(continue_hint, "modulate:a", 1.0, 0.5)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if is_done:
			get_tree().change_scene_to_file("res://cutscenes/act1intro.tscn")
		else:
			story_text.visible_characters = -1
			_on_done()
