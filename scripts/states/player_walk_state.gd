class_name PlayerWalkState
extends State

@export var actor: Player
@export var animator: AnimatedSprite2D

signal stop_movement

func _ready() -> void:
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("walk")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	var input_dir = Input.get_vector('left','right','up','down')
	actor.velocity = input_dir * actor.speed
	actor.move_and_slide()
	
	# Change direction of sprite based on movement direction
	if input_dir.x < 0:
		animator.scale.x = -1
	elif input_dir.x > 0:
		animator.scale.x = 1
	
	if Input.is_action_just_released("left") or Input.is_action_just_released("right") or Input.is_action_just_released("up") or Input.is_action_just_released("down"):
		stop_movement.emit() 
	
	if Input.is_action_just_pressed("click"):
		animator.play('attack')

