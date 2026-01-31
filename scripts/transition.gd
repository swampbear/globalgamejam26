extends Area2D

var entered = false
@export var scene: PackedScene
@export var player: CharacterBody2D

var thief = true

func _on_body_entered(body: Node2D) -> void:
	entered = true


func _on_body_exited(body: Node2D) -> void:
	entered = false
	

func _process(delta: float) -> void:
	if thief:
		if entered and player.coins == 5:
			get_tree().change_scene_to_packed(scene)
		
	elif entered:
		get_tree().change_scene_to_packed(scene)
