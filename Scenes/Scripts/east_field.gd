extends Node2D

@export var tilemap_layer: TileMapLayer

# Inventory Forge database (drag demo_database.tres here)
@export var item_database: Resource

# Item IDs from the database (example: 2–11 for flowers)
@export var item_ids_to_spawn: Array[int] = []

@export var max_spawn_amount: int = 10
var amount_spawned: int = 0

var available_cells: Array[Vector2i] = []


func _ready() -> void:
	randomize()
	setup_spawn_positions()
	spawn_items(max_spawn_amount)


func setup_spawn_positions():
	if tilemap_layer == null:
		push_error("Tilemap layer not assigned!")
		return
	
	available_cells = tilemap_layer.get_used_cells()


func spawn_items(count: int) -> void:
	if available_cells.is_empty():
		print("No tiles found.")
		return
	
	for i in range(count):
		if available_cells.is_empty():
			break
		
		# Pick random tile
		var random_index = randi_range(0, available_cells.size() - 1)
		var cell_coords: Vector2i = available_cells[random_index]
		available_cells.remove_at(random_index)
		
		var spawn_position: Vector2 = tilemap_layer.map_to_local(cell_coords)
		
		# Pick random item ID
		var item_id = item_ids_to_spawn[randi_range(0, item_ids_to_spawn.size() - 1)]
		
		# 🔥 Get item from Inventory Forge database
		var item_data = item_database.get_item(item_id)
		
		if item_data == null:
			print("Invalid item ID:", item_id)
			continue
		
		# 🔥 Create world item (Inventory Forge handles scene internally)
		var world_item = null
		
		# Try common Inventory Forge methods (depends on version)
		if item_database.has_method("create_world_item"):
			world_item = item_database.create_world_item(item_data)
		elif item_data.has_method("create_instance"):
			world_item = item_data.create_instance()
		elif item_data.has_variable("scene"):
			world_item = item_data.scene.instantiate()
			world_item.item = item_data
		
		if world_item == null:
			print("Could not spawn item:", item_id)
			continue
		
		add_child(world_item)
		world_item.global_position = spawn_position
		
		amount_spawned += 1
		print("Spawned:", amount_spawned)
