extends Control

@onready var slot_container = $NinePatchRect/GridContainer
@onready var slot_scene = preload("res://Scenes/inv_ui_slot.tscn")
@onready var weapon_slot_scene = preload("res://Scenes/inv_ui_weapon_slot.tscn")

const CATEGORY_WEAPON = 1

func _ready():
	create_weapon_slots(1)
	create_slots(7)

	await get_tree().process_frame

	Global.inventory_manager.inventory_updated.connect(update_ui)
	update_ui(Global.inventory_manager.inventory)


func create_slots(amount):
	for i in range(amount):
		var slot = slot_scene.instantiate()
		slot_container.add_child(slot)


func create_weapon_slots(amount):
	for i in range(amount):
		var slot = weapon_slot_scene.instantiate()
		slot_container.add_child(slot)


func update_ui(inventory):
	var slots = slot_container.get_children()

	var weapon_items = []
	var regular_items = []

	for entry in inventory:
		if entry == null or entry.item == null:
			continue

		if entry.item.category == CATEGORY_WEAPON:
			weapon_items.append(entry)
		else:
			regular_items.append(entry)

	var weapon_index = 0
	var regular_index = 0

	for slot in slots:
		if slot.is_weapon_slot:
			if weapon_index < weapon_items.size():
				slot.set_item(weapon_items[weapon_index])
				weapon_index += 1
			else:
				slot.set_item(null)
		else:
			if regular_index < regular_items.size():
				slot.set_item(regular_items[regular_index])
				regular_index += 1
			else:
				slot.set_item(null)
