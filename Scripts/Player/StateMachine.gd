extends Node

class_name PlayerStateMachine

const DEBUG = true

var state: Object

export (NodePath) var character_path
export (NodePath) var sprite_path
export (NodePath) var gravity_node_path


onready var character : Player = get_node(character_path)
onready var sprite : AnimatedSprite = get_node(sprite_path)
#onready var action_menu : Control = get_node(action_menu_path)

#signal activate_action_menu()
#signal disactivate_action_menu()

var history = []

func _ready():
	initialize()

func initialize():
	# Set the initial state to the first child node
	state = get_child(0)
	_enter_state()
	
func change_to(new_state):
	history.append(state.name)
	state = get_node(new_state)
	_enter_state()

func back():
	if history.size() > 0:
		state = get_node(history.pop_back())
		_enter_state()

func _enter_state():
	if DEBUG:
		print("Entering state: ", state.name)
	# Give the new state a reference to this state machine script
	state.fsm = self
	state.enter()

# Route Game Loop function calls to
# current state handler method if it exists
func _process(delta):
	if state.has_method("process"):
		state.process(delta)

func _physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)

func _input(event):
	if state.has_method("input"):
		state.input(event)

func _unhandled_input(event):
	if state.has_method("unhandled_input"):
		state.unhandled_input(event)

func _unhandled_key_input(event):
	if state.has_method("unhandled_key_input"):
		state.unhandled_key_input(event)

#func _notification(what):
#	if state && state.has_method("notification"):
#		state.notification(what)
