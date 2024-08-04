extends Node2D

@export var tile_map: TileMap

var source_id = 0

var ground_layer = 1
var environment_layer = 2

var dirt_on_grass_terrain_set = 2

var can_place_seed_data = 'can_place_seeds'
var can_place_dirt_data = 'can_place_dirt'

enum FARMING_MODES {SEEDS, DIRT}
var farming_mode_state = FARMING_MODES.DIRT

var dirt_tiles = []

func _input(_event):
	
	if Input.is_action_just_pressed("toggle_dirt"):
		farming_mode_state = FARMING_MODES.DIRT
		print('dirt')
		
	if Input.is_action_just_pressed("toggle_seeds"):
		farming_mode_state = FARMING_MODES.SEEDS
		print('seeds')
	
	if Input.is_action_just_pressed("click"):
		
		var mouse_position = get_global_mouse_position()
		var tile_mouse_position = tile_map.local_to_map(mouse_position)
		
		if farming_mode_state == FARMING_MODES.SEEDS:
			var atlas_coord = Vector2i(11, 1)
			if retrieve_custom_data(tile_mouse_position, can_place_seed_data, ground_layer):
				var level = 0
				var final_seed_level = 3
				handle_seed(tile_mouse_position, level, atlas_coord, final_seed_level)
				
		elif farming_mode_state == FARMING_MODES.DIRT:
			if retrieve_custom_data(tile_mouse_position, can_place_dirt_data, ground_layer):
				dirt_tiles.append(tile_mouse_position)
				tile_map.set_cells_terrain_connect(ground_layer, dirt_tiles, dirt_on_grass_terrain_set, 0)

func retrieve_custom_data(tile_mouse_pos, custom_data_layer, layer):
	var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_pos)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false

func handle_seed(tile_map_pos, level, atlas_coord, final_seed_level):
	tile_map.set_cell(environment_layer, tile_map_pos, source_id, atlas_coord)
	
	await get_tree().create_timer(5.0).timeout
	
	if level == final_seed_level:
		return
	else:
		var new_atlas_coord = Vector2i(atlas_coord.x + 1, atlas_coord.y)
		tile_map.set_cell(environment_layer, tile_map_pos, source_id, new_atlas_coord)
		handle_seed(tile_map_pos, level + 1, new_atlas_coord, final_seed_level)
