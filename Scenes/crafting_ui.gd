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
