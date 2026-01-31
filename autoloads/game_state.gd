extends Node

var current_mask: MaskData = null
var current_act: int = 0
var current_level_path: String = ""

var levels: Array = [
	{"name": "I", "path": "res://scenes/platformer_test_2.tscn", "unlocked": true},
	{"name": "II", "path": "res://scenes/platformer_test_3.tscn", "unlocked": false},
]

func unlock_next_level():
	for i in range(levels.size()):
		if not levels[i].unlocked:
			levels[i].unlocked = true
			return


func get_unlocked_count() ->int:
	var total = 0
	for level in levels:
		if level.unlocked:
			total += 1
		
	return total
