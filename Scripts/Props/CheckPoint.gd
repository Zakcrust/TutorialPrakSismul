extends Area2D

class_name CheckPoint

var player : Player

func _on_CheckPoint_body_entered(body):
	if body is Player:
		GameManager.checkpoint = self
		player = body
		$Sprite.play("default")


func spawn_player() -> void:
	player.global_position = global_position
	player.revive()
