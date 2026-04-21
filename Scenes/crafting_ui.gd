extends Control

var Result

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if $NinePatchRect/GridContainer/Paper/OptionButton.get_selected_id() == 0:
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 0:
			
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(2)
			Global.inventory_manager.addToInventory(12)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 1:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(3)
			Global.inventory_manager.addToInventory(13)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 2:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(4)
			Global.inventory_manager.addToInventory(14)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 3:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(5)
			Global.inventory_manager.addToInventory(15)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 4:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(6)
			Global.inventory_manager.addToInventory(16)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 5:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(7)
			Global.inventory_manager.addToInventory(17)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 6:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(8)
			Global.inventory_manager.addToInventory(18)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 7:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(9)
			Global.inventory_manager.addToInventory(19)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 8:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(10)
			Global.inventory_manager.addToInventory(20)
		elif  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 9:
			Global.inventory_manager.removeFromInventory(1)
			Global.inventory_manager.removeFromInventory(11)
			Global.inventory_manager.addToInventory(21)
	else:
		print("no wings :(")
