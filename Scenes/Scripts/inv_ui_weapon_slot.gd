extends Panel

@onready var item_visual: TextureRect = $TextureRect

var current_entry = null
var is_weapon_slot = true

const CATEGORY_WEAPON = 1


func set_item(entry):
	current_entry = entry
	
	if entry != null and entry.item != null and entry.item.category == CATEGORY_WEAPON:
		var item = entry.item
		var quantity = entry.quantity
	
		item_visual.texture = item.icon
	
	else:
		clear_slot()


func clear_slot():
	item_visual.texture = null
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
	if Global.Ui_Manager != null && current_entry != null :
		Global.Ui_Manager.itemDisc(current_entry.item.id)
	else:
		print("not loading :(")
