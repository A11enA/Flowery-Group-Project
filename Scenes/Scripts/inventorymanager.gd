extends Resource

class_name InventoryControl
# InventoryManager.gd
 
# A signal to notify the UI when the inventory changes.
signal inventory_changed
 
@export var items: Array[flower_attributes]

func add_item(item: flower_attributes):
	items.append(item)
	inventory_changed.emit()
 
func update_item(item,amount):
	if items.has(item):
		items[item] += amount
	else:
		items[item] = amount
	inventory_changed.emit()

func remove_item(item: flower_attributes):
	if items.has(item):
		items.erase(item)
		inventory_changed.emit()
