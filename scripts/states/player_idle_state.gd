class_name PlayerIdleState
extends State

@export var actor: Player
@export var animator: AnimatedSprite2D

signal start_movement

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	animator.play("idle")

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
	
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		start_movement.emit() 
	
	if Input.is_action_just_pressed("click"):
		animator.play('attack')
