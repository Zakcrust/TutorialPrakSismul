extends KinematicBody2D

class_name Player

export (int) var speed = 200
export (int) var jump_speed = -250
export (int) var gravity = 400

signal win_ui()
signal lose_ui()
signal update_score_ui()
signal update_life_ui()

var velocity : Vector2

var game_over : bool = false
var spawning : bool  = false

func lose() -> void:
	game_over = true
	set_process(false)
	$Sprite.play("dead")
	emit_signal("lose_ui")
	yield($Sprite, "animation_finished")
	queue_free()


func win() -> void:
	game_over = true
	set_process(false)
	$Sprite.play("idle")
	emit_signal("win_ui")

func die() -> void:
	if GameManager.life >= 1:
		GameManager.respawn()
		emit_signal("update_life_ui")
	else:
		lose()


func revive() -> void:
	$Sprite.play("spawn")
	spawning = true
	yield($Sprite, "animation_finished")
	spawning = false
	$Sprite.play("idle")

func update_score() -> void:
	emit_signal("update_score_ui")

func get_input():
	velocity.x = 0
	if game_over:
		return
	elif spawning:
		return
	if Input.is_action_pressed("move_right"):
		$Sprite.scale.x = 1
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		$Sprite.scale.x = -1
		velocity.x -= speed
	if is_on_floor():
		if velocity.x == 0:
			$Sprite.play("idle")
		else:
			$Sprite.play("move")
	else:
		velocity.x *= 0.8
		$Sprite.play("jump")

func _physics_process(delta):
	get_input()
	if game_over:
		return
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	position.x = clamp(position.x , 10 , 8000)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	check_height_position()


func check_height_position() -> void:
	if position.y > 620:
		die()
