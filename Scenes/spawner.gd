extends Node2D

### === CONFIG === ###

@export var tilemap_layer: TileMapLayer
const PICKUP_SCENE: PackedScene = preload("res://Scenes/baseflower.tscn")

@export var max_spawn_amount: int = 20

# Weighted spawn pools
var common_ids: Array[int] = [2,3,4,5,6]
var uncommon_ids: Array[int] = [7,8,9,10]
var rare_ids: Array[int] = [11]

# Spawn weights (adjust these to tune rarity)
@export var common_weight: int = 70
@export var uncommon_weight: int = 25
@export var rare_weight: int = 5

### === INTERNAL === ###

var available_cells: Array[Vector2i] = []

### === READY === ###

func _ready() -> void:
	randomize()

	if tilemap_layer == null:
		push_error("Tilemap layer not assigned!")
		return

	available_cells = tilemap_layer.get_used_cells()

	if available_cells.is_empty():
		push_error("No tiles found in tilemap!")
		return

	spawn_scenes(max_spawn_amount)

### === SPAWN LOGIC === ###

func spawn_scenes(count: int) -> void:
	for i in range(count):

		if available_cells.is_empty():
			print("No more available spawn positions.")
			return

		# Pick random tile
		var index = randi_range(0, available_cells.size() - 1)
		var cell_coords = available_cells[index]
		available_cells.remove_at(index)

		# Convert to world position
		var local_pos = tilemap_layer.map_to_local(cell_coords)
		var world_pos = tilemap_layer.to_global(local_pos)

		# Get weighted random item ID
		var item_id = get_weighted_item_id()

		# Spawn pickup
		var pickup = PICKUP_SCENE.instantiate()
		pickup.item_id = item_id

		get_tree().current_scene.add_child(pickup)
		pickup.global_position = world_pos

### === WEIGHTED RANDOM === ###

func get_weighted_item_id() -> int:
	var total_weight = common_weight + uncommon_weight + rare_weight
	var roll = randi_range(1, total_weight)

	if roll <= common_weight:
		return common_ids.pick_random()

	elif roll <= common_weight + uncommon_weight:
		return uncommon_ids.pick_random()

	else:
		return rare_ids.pick_random()
