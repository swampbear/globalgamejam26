extends TextureButton

signal mask_selected(mask_data)

@onready var name_label = $NameLabel

var mask_data: MaskData

func setup(data: MaskData):
	mask_data = data
	if data.icon:
		texture_normal = data.icon
		name_label.visible = false
	else:
		name_label.text = data.name

func _ready():
	custom_minimum_size = Vector2(120, 120)
	pressed.connect(_on_pressed)

func _on_pressed():
	mask_selected.emit(mask_data)
