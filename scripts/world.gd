extends Node2D

@onready var tile_map : TileMap = $TileMap

# the layer on the tilemap 
var ground_layer = 1
var environment_layer = 2

# ref to each custom data layer for tiles
var can_place_seed_custom_data = "can_place_seeds"
var can_place_dirt_custom_data = "can_place_dirt"

# tracks the different farming modes
enum FARMING_MODES {
	SEEDS,
	DIRT 
}

# init farming mode as place dirt
var farming_mode_state = FARMING_MODES.DIRT

# set mouse pos as a place to place dirt which will be used in terrain building below
var dirt_tiles = []

func _input(event):
	
	if Input.is_action_just_pressed("toggle_dirt"):
		farming_mode_state = FARMING_MODES.DIRT
	
	if Input.is_action_just_pressed("toggle_seeds"):
		farming_mode_state = FARMING_MODES.SEEDS
	
	if Input.is_action_just_pressed("click"):
		
		# the vector containing mouse pos as floats
		var mouse_pos : Vector2 = get_global_mouse_position()
		# convert mouse pos float to tilemap pos int
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		# source id of tilemap
		var source_id : int = 1
		
		if farming_mode_state == FARMING_MODES.SEEDS:
			# atlas coord of seed
			var atlas_coord : Vector2i = Vector2i(11, 1)
			if retrieve_custom_data(tile_mouse_pos, can_place_seed_custom_data, ground_layer):
				var level : int = 0
				var final_seed_level : int = 3
				handle_seeds(tile_mouse_pos, level, atlas_coord, final_seed_level)
				
		elif farming_mode_state == FARMING_MODES.DIRT:
			if retrieve_custom_data(tile_mouse_pos, can_place_dirt_custom_data, ground_layer):
				dirt_tiles.append(tile_mouse_pos)
				# run dirt terrain connect function on all coords appended in dirt_tiles list
				tile_map.set_cells_terrain_connect(ground_layer, dirt_tiles, 2, 0)
		
		
		
func retrieve_custom_data(tile_mouse_pos, custom_data_layer, layer):
		var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_pos)
		if tile_data:
			# returns custom data for tile in current mouse pos
			return tile_data.get_custom_data(custom_data_layer)
		else:
			return false

func handle_seeds(tile_map_pos, level, atlas_coord, final_seed_level):
	var source_id = 1
	tile_map.set_cell(environment_layer, tile_map_pos, source_id, atlas_coord)
	
	await get_tree().create_timer(5.0).timeout
	
	if level == final_seed_level:
		return
	else:
		var new_atlas : Vector2i = Vector2i(atlas_coord.x +1, atlas_coord.y)
		handle_seeds(tile_map_pos, level+1, new_atlas, final_seed_level)
	
		
