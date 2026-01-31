extends Control

@onready var start_button = $ButtonContainer/StartButton
@onready var quit_button = $ButtonContainer/QuitButton

func _ready():
	start_button.pressed.connect(_on_start)
	quit_button.pressed.connect(_on_quit)

func _on_start():
	get_tree().change_scene_to_file("res://cutscenes/prologue.tscn")

func _on_quit():
	get_tree().quit()
