extends Area2D

export (NodePath) var target_node

func _on_PropsInvoker_body_entered(body):
	var node = get_node(target_node)
	if body is Player:
		if node is MovingPlatform:
			node.start_timer()
			$CollisionShape2D.call_deferred("set_disabled", true)
