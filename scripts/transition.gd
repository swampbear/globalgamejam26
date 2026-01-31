extends Area2D

@export var scene: PackedScene
@export var player: CharacterBody2D

@onready var timer: Timer = $Timer


var thief = true

func _on_body_entered(body: Node2D) -> void:
	if thief:
		if player.coins == 5:
			get_tree().change_scene_to_packed(scene)
			
		else:
			player.kill()
			timer.start()
			
		
	else:
		get_tree().change_scene_to_packed(scene)


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
