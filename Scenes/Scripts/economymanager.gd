class_name EconomyControl
extends Control

const DATABASE_PATH := "res://addons/inventory_forge/demo/demo_database.tres"

@onready var database = preload(DATABASE_PATH)

var coins := 0


# Customer orders
var customers = [
	{
		"name": "Veronica",
		"order": [
			{
				"id": 11,
				"wrappedId": 21,
				"amount": 2
			},
			{
				"id": 3,
				"wrappedId": 13,
				"amount": 1
			}
		]
	},
	
	{
		"name": "Ethan",
		"order": [
			{
				"id": 6,
				"wrappedId": 16,
				"amount": 2
			},
			{
				"id": 9,
				"wrappedId": 19,
				"amount": 1
			}
		]
	},
	
	{
		"name": "Ial",
		"order": [
			{
				"id": 5,
				"wrappedId": 15,
				"amount": 2
			},
			{
				"id": 7,
				"wrappedId": 17,
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
	
	
	

# Update UI
func update_display(money):
	
	$PanelContainer/HBoxContainer/MoneyLabel.text = str(money)


# Sell flower - checks for any combination of wrapped and regular flowers
# Wrapped flowers sell for more than regular flowers
func sell_flower(id : int, amt : int):
	var item = database.get_item_by_id(id)
	
	if item == null:
		return false
	
	# Find the wrapped version of this flower
	var wrapped_id = _get_wrapped_id(id)
	
	# Check if we have enough total (wrapped + regular combined)
	if not _has_flower_amount(id, wrapped_id, amt):
		return false
	
	# Calculate the price based on wrapped and regular flowers
	var total_price = _calculate_sell_price(id, wrapped_id, amt)
	
	# Remove the flowers (wrapped first, then regular)
	_remove_flower_amount(id, wrapped_id, amt)
	
	coins += total_price
	update_display(coins)
	return true

# Helper: Get the wrapped ID for a flower
func _get_wrapped_id(id: int) -> int:
	for customer in customers:
		for requirement in customer["order"]:
			if requirement["id"] == id:
				return requirement["wrappedId"]
	return -1  # Not found

# Helper: Calculate the total sell price (wrapped flowers are worth more)
func _calculate_sell_price(id: int, wrapped_id: int, amt: int) -> int:
	var regular_item = database.get_item_by_id(id)
	if regular_item == null:
		return 0
	
	# If no wrapped version, just return regular price
	if wrapped_id == -1:
		return regular_item.sell_price * amt
	
	var wrapped_item = database.get_item_by_id(wrapped_id)
	if wrapped_item == null:
		return regular_item.sell_price * amt
	
	# Get available quantities
	var regular_stack = Global.inventory_manager.find_stack(id)
	var wrapped_stack = Global.inventory_manager.find_stack(wrapped_id)
	
	var regular_qty = 0 if regular_stack == null else regular_stack.quantity
	var wrapped_qty = 0 if wrapped_stack == null else wrapped_stack.quantity
	
	var to_price = amt
	var total_price = 0
	
	# Price wrapped flowers first (they're worth more)
	if wrapped_qty > 0:
		var price_wrapped = min(wrapped_qty, to_price)
		total_price += wrapped_item.sell_price * price_wrapped
		to_price -= price_wrapped
	
	# Then price regular flowers
	if to_price > 0:
		total_price += regular_item.sell_price * to_price
	
	return total_price

# Helper: Check if we have enough flowers (wrapped + regular combined)
func _has_flower_amount(id: int, wrapped_id: int, amt: int) -> bool:
	if wrapped_id == -1:
		# No wrapped version, just check regular
		return Global.inventory_manager.has_item_amount(id, amt)
	
	# Get stacks for both regular and wrapped flowers
	var regular_stack = Global.inventory_manager.find_stack(id)
	var wrapped_stack = Global.inventory_manager.find_stack(wrapped_id)
	
	var regular_qty = 0 if regular_stack == null else regular_stack.quantity
	var wrapped_qty = 0 if wrapped_stack == null else wrapped_stack.quantity
	
	return (regular_qty + wrapped_qty) >= amt

# Helper: Remove flowers (wrapped first, then regular)
func _remove_flower_amount(id: int, wrapped_id: int, amt: int) -> void:
	var regular_stack = Global.inventory_manager.find_stack(id)
	var wrapped_stack = Global.inventory_manager.find_stack(wrapped_id)
	
	var regular_qty = 0 if regular_stack == null else regular_stack.quantity
	var wrapped_qty = 0 if wrapped_stack == null else wrapped_stack.quantity
	
	var to_remove = amt
	
	# Remove wrapped first
	if wrapped_qty > 0:
		var remove_wrapped = min(wrapped_qty, to_remove)
		Global.inventory_manager.removeFromInventory(wrapped_id, remove_wrapped)
		to_remove -= remove_wrapped
	
	# Then remove regular
	if to_remove > 0:
		Global.inventory_manager.removeFromInventory(id, to_remove)
	



# Check customer order - checks for any combination of wrapped and regular flowers
func check_order() -> bool:
	var customer = get_current_customer()
	
	if customer == null:
		return false
	
	# Check all requirements
	for requirement in customer["order"]:
		var id = requirement["id"]
		var wrapped_id = requirement["wrappedId"]
		var amount = requirement["amount"]
		
		# Check if we have enough (wrapped + regular combined)
		if not _has_flower_amount(id, wrapped_id, amount):
			Dialogic.VAR.Order.OrderFilled = false
			return false
	
	# All requirements met
	Dialogic.VAR.Order.OrderFilled = true
	Global.UI_manager.alert("Order Filled!")
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
