extends Area2D


func _on_Saw_body_entered(body):
	if body is Player:
		body.die()
