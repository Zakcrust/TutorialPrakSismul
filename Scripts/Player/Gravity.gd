extends Node

class_name Gravity

onready var player = get_parent()

var velocity : Vector2 = Vector2.ZERO

var GRAVITY_SPEED : float = 4000

func gravity(_delta) -> Vector2:
	if not player.is_on_floor():
		velocity.y += GRAVITY_SPEED * _delta
	return velocity


func _on_Jump_jump(jump_speed):
	velocity.y = jump_speed
