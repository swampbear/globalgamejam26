extends Area2D

@export var scene: PackedScene
@export var player: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	match player.active_mask.type:
		MaskData.MaskType.THIEF:
			if player.coins != 5:
				player.kill()
				return
		
	GameState.unlock_next_level()	
	get_tree().change_scene_to_packed(scene)
