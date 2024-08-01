extends Node2D

@onready var inventory_ui = $CanvasLayer/InventoryUI

func _ready():
	inventory_ui.opened.connect(on_inventory_ui_opened)
	inventory_ui.closed.connect(on_inventory_ui_closed)

func on_inventory_ui_opened():
	get_tree().paused = true

func on_inventory_ui_closed():
	get_tree().paused = false
