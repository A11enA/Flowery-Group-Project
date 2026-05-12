extends Resource
class_name Inventory
@export var _content : Array[Item] = []

# add an item to this inventory
func add_item(item_to_add : Item):
	_content.append(item_to_add)

# add an item to this inventory
func remove_item(item_to_remove : Item):
	_content.erase(item_to_remove)

# return all items in the inventory
func get_items() -> Array[Item]:
	return _content

# check if all items needed are in the inventory	
func has_all(items : Array[Item]) -> bool:
	# make a copy of the inventory array so we dont delete it
	var needed : Array[Item] = items.duplicate()
	# eliminate items if they are available and needed
	for available in _content:
		needed.erase(available)
	# if all the items needed were found (and erased from the dupe arraty
	# return true
	return needed.is_empty()
