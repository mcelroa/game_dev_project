extends CanvasLayer

@onready var inventory_ui = $InventoryUI

func _ready():
	inventory_ui.close()

func _input(event):
	if event.is_action_pressed('toggle_inventory'):
		if inventory_ui.isOpen:
			inventory_ui.close()
		else:
			inventory_ui.open()
