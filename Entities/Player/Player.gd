extends CharacterBody2D

@export var speed = 80

@onready var animated_sprite = $AnimatedSprite2D
@onready var interact_ui = $InteractUI
@onready var inventory_ui = $InventoryUI

func _ready():
	Global.set_player_reference(self)

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	update_animation()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory_ui.visible = !inventory_ui.visible
		get_tree().paused = !get_tree().paused

func update_animation():
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		if velocity.x > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("walk")
		else:
			animated_sprite.flip_h = true
			animated_sprite.play("walk")
			

func apply_item_effect(item):
	match item['effect']:
		'Speed':
			print('Speed Increased')
		_:
			print('Default no effect')
