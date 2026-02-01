extends Area2D

@export var player: CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	print(player.active_mask.type)
	player.add_coin()
	queue_free()
	match player.active_mask.type:
		MaskData.MaskType.ANGEL:
			if player.coins > 0:
				player.kill()
				return

	
