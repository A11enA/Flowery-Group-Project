extends Node2D

@export var tilemap_layer: TileMapLayer
@export var item_database: Resource
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
		print("No available spawn positions!")
		return
	
	for i in range(count):
		if available_cells.is_empty():
			break
		
		var random_index = randi_range(0, available_cells.size() - 1)
		var cell_coords: Vector2i = available_cells[random_index]
		available_cells.remove_at(random_index)
		
		var spawn_position: Vector2 = tilemap_layer.map_to_local(cell_coords)
		
		var item_id = item_ids_to_spawn[randi_range(0, item_ids_to_spawn.size() - 1)]
		var item_data = item_database.get_item(item_id)
		
		if item_data == null:
			print("Invalid item ID:", item_id)
			continue
		
		# INVENTORY FORGE SPAWN
		var world_item = item_database.create_world_item(item_data)
		
		if world_item == null:
			print("Failed to create world item")
			continue
		
		add_child(world_item)
		world_item.global_position = spawn_position
		
		# Track spawn position (if supported)
		if world_item.has_variable("spawn_cell"):
			world_item.spawn_cell = cell_coords
		
		# Optional: connect pickup signal if exists
		if world_item.has_signal("picked_up"):
			world_item.connect("picked_up", Callable(self, "_on_item_picked"))
		
		amount_spawned += 1
		print("Spawned:", amount_spawned)
