extends Node

var fsm: PlayerStateMachine

var velocity : Vector2

func next(next_state):
	get_tree()
	fsm.change_to(next_state)

func exit():
	fsm.back()


func enter() -> void:
	print("Current state : %s" % self.name)


func process(_delta):
	pass

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		fsm.character.scale.x = 1
		fsm.sprite.play("move")
		velocity.x += fsm.character.speed
	if Input.is_action_pressed("move_left"):
		fsm.character.scale.x = -1
		fsm.sprite.play("move")
		velocity.x -= fsm.character.speed
	if velocity.x == 0 and fsm.character.is_on_floor():
		fsm.sprite.play("idle")

func _physics_process(delta):
	get_input()
	velocity.y += fsm.character.gravity * delta
	velocity = fsm.character.move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if fsm.character.is_on_floor():
			fsm.sprite.play("jump")
			velocity.y = fsm.character.jump_speed

func input(_event):
	pass
