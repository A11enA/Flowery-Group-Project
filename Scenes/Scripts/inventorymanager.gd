class_name InventoryControl
extends Node

var inventory := []
signal inventory_updated(inventory)

const DATABASE_PATH := "res://addons/inventory_forge/demo/demo_database.tres"

@onready var database = preload(DATABASE_PATH)

var max_slots := 10
var invFull := false


# Ready
func _ready():
	
	Global.inventory_manager = self


func _process(delta):
	
	if get_used_slots() >= max_slots:
		invFull = true
	else:
		invFull = false


# Find existing stack
func find_stack(id):
	
	for entry in inventory:
	
		if entry == null:
			continue
	
		if entry.item == null:
			continue
	
		if entry.item.id == id:
			return entry
	
	return null


# Get used slots
func get_used_slots() -> int:
	
	return inventory.size()
	

# Add item
func addToInventory(id) -> bool:
	
	var item = database.get_item_by_id(id)
	
	if not item:
		print("Item not found:", id)
		return false
	
	var stack = find_stack(id)
	
	if stack:
	
		stack.quantity += 1
	
		emit_signal("inventory_updated", inventory)
	
		return true
	
	
	if get_used_slots() >= max_slots:
	
		PopUp.alert("Inventory Full!")
	
		return false
	
	
	inventory.append({
		"item": item,
		"quantity": 1
	})
	
	emit_signal("inventory_updated", inventory)
	
	return true


# Remove item
func removeFromInventory(id, amount := 1) -> bool:
	
	var stack = find_stack(id)
	
	if stack == null:
	
		PopUp.alert("None in Inventory!")
	
		return false
	
	
	if stack.quantity < amount:
	
		PopUp.alert("Not Enough in Inventory!")
	
		return false
	
	
	stack.quantity -= amount
	
	
	if stack.quantity <= 0:
		inventory.erase(stack)
	
	
	emit_signal("inventory_updated", inventory)
	
	return true


# Check inventory amount
func has_item_amount(id, amount) -> bool:
	
	var stack = find_stack(id)
	
	if stack == null:
		return false
	
	return stack.quantity >= amount
