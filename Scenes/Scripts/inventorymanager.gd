class_name InventoryControl extends Node

var inventory := [] # [{item: item_resource, quantity: int}]
signal inventory_updated(inventory)

const DATABASE_PATH := "res://addons/inventory_forge/demo/demo_database.tres"
@onready var database = preload(DATABASE_PATH)

var max_slots := 9


func _ready():
	Global.inventory_manager = self


# --------------------------------------------------
# Find existing stack
# --------------------------------------------------
func find_stack(id):
	for entry in inventory:
		if entry == null:
			continue

		if entry.item == null:
			continue

		if entry.item.id == id:
			return entry

	return null


# --------------------------------------------------
# Get used slots
# --------------------------------------------------
func get_used_slots() -> int:
	return inventory.size()


# --------------------------------------------------
# Add item with stacking + slot limit
# --------------------------------------------------
func addToInventory(id) -> bool:
	var item = database.get_item_by_id(id)
	if not item:
		print("Item not found:", id)
		return false

	var stack = find_stack(id)

	# Stack if exists
	if stack:
		stack.quantity += 1
		emit_signal("inventory_updated", inventory)
		return true

	# Slot limit check for new stacks
	if get_used_slots() >= max_slots:
		print("inventory full")
		return false

	# Create new stack
	inventory.append({
		"item": item,
		"quantity": 1
	})

	emit_signal("inventory_updated", inventory)
	return true


# --------------------------------------------------
# Remove item safely
# --------------------------------------------------
func removeFromInventory(id, amount := 1) -> bool:
	var stack = find_stack(id)

	if stack == null:
		return false

	if stack.quantity < amount:
		return false

	stack.quantity -= amount

	if stack.quantity <= 0:
		inventory.erase(stack)

	emit_signal("inventory_updated", inventory)
	return true
