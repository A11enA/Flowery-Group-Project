class_name  InventoryControl extends Node

var inventory := []
signal inventory_updated(inventory)
const DATABASE_PATH := "res://addons/inventory_forge/demo/demo_database.tres"

@onready var database = preload(DATABASE_PATH)

func _ready():
	Global.inventory_manager = self

func addToInventory(id) -> void:
	var item = database.get_item_by_id(id)
	
	if item:
		inventory.append(item)
		emit_signal("inventory_updated", inventory)
	else:
		print("Item not found:", id)
