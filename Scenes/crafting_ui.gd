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
			Global.inventory_manager.addToInventory(12)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 1:
			Global.inventory_manager.addToInventory(13)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 2:
			Global.inventory_manager.addToInventory(14)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 3:
			Global.inventory_manager.addToInventory(15)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 4:
			Global.inventory_manager.addToInventory(16)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 5:
			Global.inventory_manager.addToInventory(17)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 6:
			Global.inventory_manager.addToInventory(18)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 7:
			Global.inventory_manager.addToInventory(19)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 8:
			Global.inventory_manager.addToInventory(20)
		if  $NinePatchRect/GridContainer/Unwrapped/OptionButton2.get_selected_id() == 9:
			Global.inventory_manager.addToInventory(21)
