extends CanvasLayer

@onready var act_title = $CenterContainer/VBoxContainer/ActTitle
@onready var subtitle = $CenterContainer/VBoxContainer/Subtitle
@onready var mask_image = $CenterContainer/VBoxContainer/MaskImage

func _ready():
	# Start invisible
	act_title.modulate.a = 0
	mask_image.modulate.a = 0
	
	# Animate
	var tween = create_tween()
	tween.tween_property(act_title, "modulate:a", 1.0, 0.8) 
	tween.tween_property(subtitle, "modulate:a", 1.0, 0.5)
	tween.tween_property(mask_image, "modulate:a", 1.0, 1.0)
	tween.tween_interval(2.0)
	tween.tween_callback(_next)

func _next():
	get_tree().change_scene_to_file("res://menus/maskmenu/mask_selection.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_next()
