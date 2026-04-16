extends Control

@onready var slot_container = $NinePatchRect/GridContainer
@onready var slot_scene = preload("res://Scenes/inv_ui_slot.tscn")

func _ready():
	create_slots(6)
	
	await get_tree().process_frame
	
	Global.inventory_manager.inventory_updated.connect(update_ui)
	update_ui(Global.inventory_manager.inventory)

func create_slots(amount):
	for i in amount:
		var slot = slot_scene.instantiate()
		slot_container.add_child(slot)

func update_ui(inventory):
	var slots = slot_container.get_children()
	
	for i in range(slots.size()):
		if i < inventory.size():
			slots[i].set_item(inventory[i])
		else:
			slots[i].set_item(null)
