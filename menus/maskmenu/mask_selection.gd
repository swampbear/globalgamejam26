extends Control

# Mask details
@onready var mask_preview = $LeftPanel/MarginContainer/LeftContent/DetailsContainer/MaskPreview
@onready var mask_name = $LeftPanel/MarginContainer/LeftContent/DetailsContainer/MaskName
@onready var description = $LeftPanel/MarginContainer/LeftContent/DetailsContainer/Description
@onready var positive_label = $LeftPanel/MarginContainer/LeftContent/DetailsContainer/PositiveLabel
@onready var negative_label = $LeftPanel/MarginContainer/LeftContent/DetailsContainer/NegativeLabel
@onready var start_button = $LeftPanel/MarginContainer/LeftContent/DetailsContainer/StartButton

# Level list
@onready var level_list = $LeftPanel/MarginContainer/LeftContent/LevelList

# Mask grid
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
var selected_level_index: int = -1
var level_buttons: Array = []

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	start_button.disabled = true
	_clear_details()
	_populate_grid()
	_populate_levels()

func _populate_levels():
	for i in range(GameState.levels.size()):
		var level = GameState.levels[i]
		
		var button = Button.new()
		button.text = level.name
		button.custom_minimum_size = Vector2(100, 100)
		button.disabled = not level.unlocked
		button.pressed.connect(_on_level_selected.bind(i))
		
		# Style unlocked buttons
		_style_level_button(button, level.unlocked, false)
		
		level_list.add_child(button)
		level_buttons.append(button)
	
	# Auto-select highest unlocked level
	_on_level_selected(GameState.get_unlocked_count()-1)
	
func _style_level_button(button: Button, unlocked: bool, selected: bool):
	# Normal style
	var normal_style = StyleBoxFlat.new()
	normal_style.corner_radius_top_left = 6
	normal_style.corner_radius_top_right = 6
	normal_style.corner_radius_bottom_left = 6
	normal_style.corner_radius_bottom_right = 6
	
	if selected:
		normal_style.bg_color = Color("#c9a227")
		button.add_theme_color_override("font_color", Color("#0d0d1a"))
	elif unlocked:
		normal_style.bg_color = Color("#252540")
		normal_style.border_width_left = 2
		normal_style.border_width_right = 2
		normal_style.border_width_top = 2
		normal_style.border_width_bottom = 2
		normal_style.border_color = Color("#3a3a5c")
		button.add_theme_color_override("font_color", Color("#e8d5a3"))
	else:
		normal_style.bg_color = Color("#151520")
		button.add_theme_color_override("font_color", Color("#555555"))
	
	button.add_theme_stylebox_override("normal", normal_style)
	
	# Hover style (only for unlocked)
	if unlocked:
		var hover_style = normal_style.duplicate()
		hover_style.border_color = Color("#c9a227")
		button.add_theme_stylebox_override("hover", hover_style)
	
	# Disabled style
	if not unlocked:
		var disabled_style = normal_style.duplicate()
		button.add_theme_stylebox_override("disabled", disabled_style)
		button.add_theme_color_override("font_disabled_color", Color("#555555"))
	
	button.add_theme_font_size_override("font_size", 48)

func _on_level_selected(index: int):
	selected_level_index = index
	GameState.current_level_path = GameState.levels[index].path
	
	# Update all button styles
	for i in range(level_buttons.size()):
		var level = GameState.levels[i]
		_style_level_button(level_buttons[i], level.unlocked, i == index)
	
	_check_can_start()

func _populate_grid():
	for mask in masks:
		var button = MaskButtonScene.instantiate()
		grid.add_child(button)
		button.setup(mask)
		button.mask_selected.connect(_on_mask_selected)

func _on_mask_selected(mask):
	selected_mask = mask
	_show_details(mask)
	_check_can_start()

func _check_can_start():
	start_button.disabled = selected_mask == null or selected_level_index == -1

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
	if selected_mask and selected_level_index >= 0:
		GameState.current_level = selected_level_index
		GameState.current_mask = selected_mask
		get_tree().change_scene_to_file(GameState.current_level_path)
