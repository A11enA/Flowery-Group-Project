extends Panel

@onready var item_visual: TextureRect = $TextureRect
@onready var stack_label: Label = $StackAmount

var current_entry = null # stores the full stack (item + quantity)

func set_item(entry):
	current_entry = entry
	
	if entry:
		var item = entry["item"]
		var quantity = entry["quantity"]
		
		# Set icon
		item_visual.texture = item.icon
		
		# Handle stack text (Inventory Forge style)
		if quantity > 1:
			stack_label.text = str(quantity)
			stack_label.visible = true
		else:
			stack_label.visible = false
	else:
		item_visual.texture = null
		stack_label.visible = false

func remove_item(amount := 1):
	if current_entry == null:
		print("No item in slot")
		return
	
	if not current_entry.has("item"):
		print("Invalid slot data")
		return
	
	var item = current_entry["item"]
	
	if item == null:
		print("Item is null")
		return
	
	var id = item.id
	
	var inv = Global.inventory_manager
	
	if inv == null:
		print("Inventory manager not found")
		return
	
	# Optional safety check
	if not inv.find_stack(id):
		print("Item not found in inventory")
		return
	
	inv.removeFromInventory(id, amount)
