class_name FiniteStateMachine
extends Node

@export var state: State

func _ready():
	change_state(state)

func change_state(new_state: State):
	# check if current state is type State
	if state is State:
		# if current state is State then exit this state
		state._exit_state()
	# enter new state
	new_state._enter_state()
	# set the state as newly entered state
	state = new_state
