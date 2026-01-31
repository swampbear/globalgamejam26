extends CanvasLayer

@onready var dialogue_text = $PanelContainer/MarginContainer/VBoxContainer/DialogueText

var is_done = false

func _ready():
	dialogue_text.visible_characters = 0
	
	var total = dialogue_text.get_total_character_count()
	var tween = create_tween()
	tween.tween_property(dialogue_text, "visible_characters", total, total / 30.0)
	tween.tween_callback(_on_done)

func _on_done():
	is_done = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if is_done:
			get_tree().change_scene_to_file("res://menus/maskmenu/mask_selection.tscn")
		else:
			dialogue_text.visible_characters = -1
			_on_done()
