class_name EconomyControl
extends Control

const DATABASE_PATH := "res://addons/inventory_forge/demo/demo_database.tres"

@onready var database = preload(DATABASE_PATH)

var coins = 0


# Customer orders
var customers = [
	{
		"name": "Veronica",
		"order": [
			{
				"id": 11,
				"amount": 2
			},
			{
				"id": 3,
				"amount": 1
			}
		]
	},
	
	{
		"name": "Ethan",
		"order": [
			{
				"id": 6,
				"amount": 2
			},
			{
				"id": 9,
				"amount": 1
			}
		]
	},
	
	{
		"name": "Ial",
		"order": [
			{
				"id": 5,
				"amount": 2
			},
			{
				"id": 7,
				"amount": 1
			}
		]
	}
]


# Ready
func _ready() -> void:
	Global.economy_manager = self
	
	database = load(DATABASE_PATH)
	
	update_display(coins)
	
	
	Global.economy_manager = self
	
	database = load(DATABASE_PATH)
	
	update_display(coins)
	
	

# Update UI
func update_display(money):
	
	$PanelContainer/HBoxContainer/MoneyLabel.text = str(money)


# Sell flower
func sell_flower(id : int, amt : int):
	var item = database.get_item_by_id(id)
	
	var stack = Global.inventory_manager.find_stack(id)
	
	if stack == null || stack.quantity < amt:
		return false
	
	Global.inventory_manager.removeFromInventory(id, amt)
	
	coins += item.sell_price * amt
	
	update_display(coins)
	
	return true


# Check customer order
# Check current order
func check_order() -> bool:
	var customer = get_current_customer()
	
	if customer == null:
		return false
	
	
	for requirement in customer["order"]:
	
		var id = requirement["id"]
	
		var amount = requirement["amount"]
	
		if !Global.inventory_manager.has_item_amount(id, amount):
	
			Dialogic.VAR.Order.OrderFilled = false
	
			return false
	
	Dialogic.VAR.Order.OrderFilled = true
	PopUp.alert("Order Filled!")

	return true

# Get current customer
func get_current_customer():
	if Dialogic.VAR.Order.VeronicaOrder:
		return customers[0]
	
	if Dialogic.VAR.Order.EthanOrder:
		return customers[1]
	
	if Dialogic.VAR.Order.IalOrder:
		return customers[2]
	
	return null
