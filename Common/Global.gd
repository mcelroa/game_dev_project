extends Node

var inventory = []

signal inventory_updated

var player_node: Node = null

func _ready():
	inventory.resize(30)

func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]['type'] == item['type'] and inventory[i]['effect'] == item['effect']:
			inventory[i]['quantity'] += item['quantity']
			print('item added', inventory)
			inventory_updated.emit()
			return true
		elif inventory[i] == null:
			inventory[i] = item
			print('item added', inventory)
			inventory_updated.emit()
			return true
		return false

func remove_item():
	inventory_updated.emit()

func set_player_reference(player):
	player_node = player
