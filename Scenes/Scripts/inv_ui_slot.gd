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
