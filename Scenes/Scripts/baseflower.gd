extends Area2D

@export var item_id: int
@onready var sprite: Sprite2D = $Sprite2D

const DATABASE_PATH := "res://addons/inventory_forge/demo/demo_database.tres"
@onready var database = preload(DATABASE_PATH)

func _ready():
	var item = database.get_item_by_id(item_id)

	if item:
		# Make sure your database item has an "icon" property
		if item.icon:
			sprite.texture = item.icon
		else:
			print("Item has no icon:", item_id)
	else:
		print("Invalid item ID:", item_id)

func _on_body_entered(body):
	if body is Player:
		print("Picked up item:", item_id)

		if Global.inventory_manager:
			Global.inventory_manager.addToInventory(item_id)
		else:
			print("Inventory manager missing!")

		queue_free()
