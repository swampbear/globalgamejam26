extends Node

var current_mask: MaskData = null
var current_level: int = 0
var current_level_path: String = ""
var intro_hero_sound_src: String = ""

var levels: Array = [
	{"id":0, "name": "I", "path": "res://scenes/pick_up_test.tscn", "unlocked": true},
	{"id":1, "name": "II", "path": "res://scenes/platformer_test_3.tscn", "unlocked": false},
	{"id":2, "name": "III", "path": "res://scenes/batman.tscn", "unlocked": false},
]

func unlock_next_level():
	if current_level+1 == get_unlocked_count():
		levels[current_level+1].unlocked = true


func get_unlocked_count() ->int:
	var total = 0
	for level in levels:
		if level.unlocked:
			total += 1
		
	return total

func get_intro_hero_sound():
	match current_mask.type:
		MaskData.MaskType.THIEF:
			intro_hero_sound_src = "res://audio/Thief/Thief_01.wav"
		MaskData.MaskType.ANGEL:
			intro_hero_sound_src = "res://audio/Angel/Angel_01.wav"
		MaskData.MaskType.DEVIL:
			intro_hero_sound_src = "res://audio/Devil/Devil_01.wav"
		MaskData.MaskType.KNIGHT:
			intro_hero_sound_src = "res://audio/Knight/Knight_01.wav"
		MaskData.MaskType.CYCLOPS:
			intro_hero_sound_src = "res://audio/Cyclops/Cyclops_01.wav"
