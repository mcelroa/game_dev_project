extends Node2D

@export var noise_height_text : NoiseTexture2D
@export var noise_tree_text : NoiseTexture2D

var noise : Noise
var tree_noise : Noise

var width : int = 200
var height : int = 200

@onready var tile_map = $TileMap
var source_id = 1

# Layers
var water_layer = 0
var ground_1_layer = 1
var ground_2_layer = 2
var cliff_layer = 3
var environment_layer = 4

var water_atlas = Vector2i(0, 1)
var land_atlas = Vector2i(0, 0)

var sand_tiles_arr = []
var terrain_sand_int = 0

var grass_tiles_arr = []
var terrain_grass_int = 1

var cliff_tiles_arr = []
var terrain_cliff_int = 3

var grass_atlas_arr = [Vector2i(1,0),Vector2i(2,0), Vector2i(3,0), Vector2i(4,0), Vector2i(5,0)]

var palm_tree_atlas_arr = [Vector2i(12,2),Vector2i(15,2)]
var oak_tree_atlas = Vector2i(15,6)


func _ready():
	noise = noise_height_text.noise
	tree_noise = noise_tree_text.noise
	generate_world()
	
func generate_world():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val : float = noise.get_noise_2d(x,y)
			var tree_noise_val : float = tree_noise.get_noise_2d(x,y)
			
			# placing ground
			if noise_val >= 0.0:
				# placing sand and tree
				if noise_val > 0.05 and noise_val < 0.17 and tree_noise_val > 0.5:
					tile_map.set_cell(environment_layer, Vector2i(x,y), source_id, palm_tree_atlas_arr.pick_random())
				if noise_val > 0.2:
					grass_tiles_arr.append(Vector2i(x, y))
					if noise_val > 0.25:
						if noise_val < 0.35 and tree_noise_val > 0.5:
							tile_map.set_cell(environment_layer, Vector2i(x,y), source_id, oak_tree_atlas)
						tile_map.set_cell(ground_2_layer, Vector2i(x,y), source_id, grass_atlas_arr.pick_random())
					if noise_val > 0.4:
						cliff_tiles_arr.append(Vector2i(x, y))
				sand_tiles_arr.append(Vector2i(x, y))
			
			# placing water
			tile_map.set_cell(water_layer, Vector2(x, y), source_id, water_atlas)
	
	tile_map.set_cells_terrain_connect(ground_1_layer,sand_tiles_arr, terrain_sand_int, 0)
	tile_map.set_cells_terrain_connect(ground_1_layer,grass_tiles_arr, terrain_grass_int, 0)
	tile_map.set_cells_terrain_connect(cliff_layer,cliff_tiles_arr, terrain_cliff_int, 0)
