extends Area2D

var entered = false
@export var scene: String = "res://scenes/"


func _on_body_entered(body: Node2D) -> void:
	entered = true


func _on_body_exited(body: Node2D) -> void:
	entered = false
	

func _process(delta: float) -> void:
	if entered:
		get_tree().change_scene_to_file(scene)
