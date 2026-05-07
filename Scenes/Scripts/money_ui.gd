class_name EconomyControl extends Control

const DATABASE_PATH := "res://data/items/item_database.tres"
var database: ItemDatabase
var coins = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.economy_manager = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_display(money):
	$MoneyLabel.text = str(money)

func sell_flower(id : int):
	var item = database.get_item_by_id(id)
	var stack = Global.inventory_manager.find_stack(id)

	if stack == null:
		return ""
	else:
		coins += item.sell_price
		update_display(coins)
