extends Node

var fsm: PlayerStateMachine
var velocity : Vector2

var jump_speed : float = -1800

signal jump(jump_speed)

func next(next_state):
	get_tree()
	fsm.change_to(next_state)

func exit():
	fsm.back()


func enter() -> void:
	print("Current state : %s" % self.name)
	emit_signal("jump", jump_speed)
	fsm.sprite.play("jump")


func process(_delta):
	velocity = fsm.gravity.gravity(_delta)
	if Input.is_action_pressed("move_left"):
		velocity.x = -1 
		fsm.sprite.scale.x = -1
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
		fsm.sprite.scale.x = 1
	
	fsm.character.move_and_slide(velocity * (fsm.character.SPEED * 0.7),Vector2.UP )
	
#	if(fsm.character.is_on_floor()):
#		next("Move")

func physics_process(_delta):
	pass

func input(_event):
	pass
