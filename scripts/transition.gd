extends Area2D

var entered = false



func _on_body_entered(body: Node2D) -> void:
	entered = true


func _on_body_exited(body: Node2D) -> void:
	entered = false
	

func _process(delta: float) -> void:
	if entered:
		get_tree().change_scene_to_file("res://scenes/platformer_test_3.tscn")
