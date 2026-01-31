extends Control

@onready var mask_preview = $LeftPanel/MarginContainer/VBoxContainer/MaskPreview
@onready var mask_name = $LeftPanel/MarginContainer/VBoxContainer/MaskName
@onready var description = $LeftPanel/MarginContainer/VBoxContainer/Description
@onready var positive_label = $LeftPanel/MarginContainer/VBoxContainer/PositiveLabel
@onready var negative_label = $LeftPanel/MarginContainer/VBoxContainer/NegativeLabel
@onready var start_button = $LeftPanel/MarginContainer/VBoxContainer/StartButton
@onready var grid = $RightPanel/MarginContainer/GridContainer

const MaskButtonScene = preload("res://menus/maskmenu/mask_button.tscn")

var masks: Array = [
	preload("res://assets_tho/masks/thief.tres"),
	preload("res://assets_tho/masks/angel.tres"),
	preload("res://assets_tho/masks/cyclops.tres"),
	preload("res://assets_tho/masks/knight.tres"),
	preload("res://assets_tho/masks/devil.tres"),
	preload("res://assets_tho/masks/mole.tres"),
]

var selected_mask = null

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	_clear_details()
	_populate_grid()

func _populate_grid():
	print("Populating grid with ", masks.size(), " masks")
	for mask in masks:
		print("Adding mask: ", mask.name)
		var button = MaskButtonScene.instantiate()
		grid.add_child(button)
		button.setup(mask)
		button.mask_selected.connect(_on_mask_selected)

func _on_mask_selected(mask):
	selected_mask = mask
	_show_details(mask)
	start_button.disabled = false

func _show_details(mask):
	mask_preview.texture = mask.icon
	mask_name.text = mask.name
	description.text = mask.description
	positive_label.text = "✓ " + mask.positive_effect
	negative_label.text = "✗ " + mask.negative_effect

func _clear_details():
	mask_preview.texture = null
	mask_name.text = "Select a mask"
	description.text = ""
	positive_label.text = ""
	negative_label.text = ""

func _on_start_pressed():
	if selected_mask:
		GameState.current_mask = selected_mask
		get_tree().change_scene_to_file("res://cutscenes/act1intro.tscn")
