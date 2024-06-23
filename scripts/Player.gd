class_name Player
extends CharacterBody2D

@export var speed = 100

@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var player_idle_state = $FiniteStateMachine/PlayerIdleState as PlayerIdleState
@onready var player_walk_state = $FiniteStateMachine/PlayerWalkState as PlayerWalkState



func _ready():
	# player idle signals
	player_idle_state.start_movement.connect(fsm.change_state.bind(player_walk_state))
	
	# player walk signals
	player_walk_state.stop_movement.connect(fsm.change_state.bind(player_idle_state))
	
