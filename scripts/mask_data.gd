extends Resource
class_name MaskData

enum MaskType { THIEF, ANGEL, CYCLOPS, KNIGHT, DEVIL, MOLE }

@export var type: MaskType
@export var name: String = ""
@export var icon: Texture2D
@export_multiline var description: String = ""
@export var positive_effect: String = ""
@export var negative_effect: String = ""
