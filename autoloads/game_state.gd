extends Node

var current_mask: MaskData = null
var current_level: int = 0
var current_level_path: String = ""

var levels: Array = [
	{"id":0, "name": "I", "path": "res://scenes/platformer_test_2.tscn", "unlocked": true},
	{"id":1, "name": "II", "path": "res://scenes/platformer_test_3.tscn", "unlocked": false},
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
