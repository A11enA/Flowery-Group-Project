class_name  InventoryControl extends Node

var inventory := [] # [{item: item_resource, quantity: int}]
signal inventory_updated(inventory)
const DATABASE_PATH := "res://addons/inventory_forge/demo/demo_database.tres"

@onready var database = preload(DATABASE_PATH)

func _ready():
	Global.inventory_manager = self
	

func find_stack(id):
	for entry in inventory:
		if entry.item.id == id:
			return entry
	return null

func addToInventory(id) -> void:
	var item = database.get_item_by_id(id)
	if not item:
		print("Item not found:", id)
		return
	
	var stack = find_stack(id)
	
	if stack:
		stack.quantity += 1
	else:
		inventory.append({
			"item": item,
			"quantity": 1
		})
	
	emit_signal("inventory_updated", inventory)
