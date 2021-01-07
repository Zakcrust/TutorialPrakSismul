extends Area2D


func _on_Collectables_body_entered(body):
	if body is Player:
		$AnimatedSprite.play("collect")
		GameManager.score += 1
		body.update_score()
		$Collider.call_deferred("set_disabled", true)
		yield($AnimatedSprite, "animation_finished")
		queue_free()
