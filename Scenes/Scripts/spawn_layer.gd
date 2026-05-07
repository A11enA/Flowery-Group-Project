extends Node2D

### SCENE SPAWNER ###
### needs an array of scenes to spawn
### needs a position to spawn, either random, random around a point, or on a tile
### boolean for tilemaps ornot tilemaps

### tilemaps
### put all the available spawning positions into an array
### go through and determine which will be a spawn point
### delete the spawn point from the list of avialable spawning positions
### if the item is picked up, add the position back to the list of avialable spawning positions

@export var tilemap_layer: TileMapLayer
# this is if you are just using scenes
#@export var scenes_to_spawn: Array[PackedScene] = []
# for a scene that uses custom resources, do this
const PICKUPS_SCENE: PackedScene = preload("res://Scenes/baseflower.tscn")
@export var resources_to_spawn: Array[Resource] = []
#const SPAWN_CUSTOM_DATA_NAME = "Spawnable"
#const SPAWN_CUSTOM_DATA_VALUE = 1
@export var max_spawn_amount: int = 10
var amount_spawned: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	spawn_scenes(max_spawn_amount)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn_scenes(count: int) -> void:
	if tilemap_layer == null:
		print("Tilemap layer node not assigned!")
		return
	
	# get all used cell coordinates in the specified layer
	var used_cells: Array[Vector2i] = tilemap_layer.get_used_cells()
	
	if used_cells.is_empty():
		print("No tiles found.")
		return
	
	for i in range(count):
		# select a random tile the array starts with 0 so subtract 1
		var random_index = randi_range(0, used_cells.size() - 1)
		var cell_coords: Vector2i = used_cells[random_index]
		
		# remove the choosen cell from the array
		used_cells.remove_at(random_index)
		
		# convert from tile coords to world position
		var spawn_position: Vector2 = tilemap_layer.map_to_local(cell_coords)
		
		# select a random scene
		var random_scene_index = randi_range(0, resources_to_spawn.size() - 1)
		var spawn_resource: Resource = resources_to_spawn[random_scene_index]
		
		# instance the selected scene
		var new_instance = PICKUPS_SCENE.instantiate()
		new_instance.item = spawn_resource
		
		# set scene instance position and add to the scene tree
		add_child(new_instance) # what should be the parent of the new scene????
		new_instance.global_position = spawn_position
		amount_spawned += 1
		print(amount_spawned)
