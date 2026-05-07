extends Panel

@onready var item_visual: TextureRect = $ItemSpot
@onready var stack_label: Label = $StackAmount

var current_entry = null
var is_weapon_slot = false

func _ready():
	#print_tree_pretty()
	print($Button.size)
	print($Button.global_position)

func set_item(entry):
	current_entry = entry

	if entry != null and entry.item != null and entry.item.category != 1:
		var item = entry.item
		var quantity = entry.quantity

		item_visual.texture = item.icon

		if quantity > 1:
			stack_label.text = str(quantity)
			stack_label.visible = true
		else:
			stack_label.visible = false
	else:
		clear_slot()


func clear_slot():
	item_visual.texture = null
	stack_label.visible = false
	current_entry = null


func remove_item(amount := 1):
	if current_entry == null:
		return

	var item = current_entry.item
	if item == null:
		return

	var inv = Global.inventory_manager
	if inv == null:
		return

	inv.removeFromInventory(item.id, amount)


func _on_button_pressed():
	print("Press!")
	if Global.UI_manager != null && current_entry != null :
		Global.UI_manager.itemDisc(current_entry.item.id)
