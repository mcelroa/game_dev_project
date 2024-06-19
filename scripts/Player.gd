extends CharacterBody2D

@export var speed = 100
@onready var animated_sprite = $AnimatedSprite2D

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func play_animation():
	
	if Input.is_action_pressed("left"):
		animated_sprite.flip_h = true
		animated_sprite.play("walk")
	
	if Input.is_action_pressed("right"):
		animated_sprite.flip_h = false
		animated_sprite.play("walk")
	
	if Input.is_action_pressed("up"):
		animated_sprite.play("walk")
	
	if Input.is_action_pressed("down"):
		animated_sprite.play("walk")
	
	if Input.is_action_just_released("left") or Input.is_action_just_released("right") or Input.is_action_just_released("up") or Input.is_action_just_released("down"):
		animated_sprite.play("idle")

func _physics_process(delta):
	get_input()
	play_animation()
	move_and_slide()

