extends Control

@onready var item_icon = $InnerBorder/ItemIcon
@onready var item_qty = $InnerBorder/ItemQty
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType
@onready var item_effect = $DetailsPanel/ItemEffect
@onready var details_panel = $DetailsPanel
@onready var usage_panel = $UsagePanel

# slot item
var item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#default empty slot
func set_empty():
	item_icon.texture = null
	item_qty.text = ''

func set_item(new_item):
	item = new_item
	item_icon.texture = new_item['texture']
	item_qty.text = str(new_item['quantity'])
	item_name.text = str(new_item['name'])
	item_type.text = str(new_item['type'])
	if item['effect'] != '':
		item_effect.text = str('+ ', item['effect'])
	else:
		item_effect.text = ''


func _on_item_button_pressed():
	if item != null:
		usage_panel.visible = !usage_panel.visible


func _on_item_button_mouse_entered():
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true


func _on_item_button_mouse_exited():
	details_panel.visible = false


func _on_drop_button_pressed():
	if item != null:
		var drop_position = Global.player_node.global_position
		var drop_offset = Vector2(0, 50)
		drop_offset = drop_offset.rotated(Global.player_node.rotation)
		Global.drop_item(item, drop_position + drop_offset)
		Global.remove_item(item['type'], item['effect'])
		usage_panel.visible = false


func _on_use_button_pressed():
	usage_panel.visible = false
	
	if item != null and item['effect'] != '':
		if Global.player_node:
			Global.player_node.apply_item_effect(item)
			Global.remove_item(item['type'], item['effect'])
		
		else:
			print('Player could not be found')
