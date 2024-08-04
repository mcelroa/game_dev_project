@tool
extends Node2D

@export var item_type = ''
@export var item_name = ''
@export var item_effect = ''
@export var item_texture: Texture
var scene_path = "res://Inventory/inventory_item.tscn"

@onready var item_sprite = $Sprite2D

func _ready():
	if not Engine.is_editor_hint():
		item_sprite.texture = item_texture

func _process(delta):
	if Engine.is_editor_hint():
		item_sprite.texture = item_texture
