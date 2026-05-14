extends MarginContainer

@export var save1_button: Button
@export var save2_button: Button
@export var save3_button: Button
@export var save4_button: Button

var title_screen_buttons: Array

# Cache references to the save slot buttons for hover animation.
func _ready() -> void:
	title_screen_buttons = [save1_button, save2_button, save3_button, save4_button]

# Update button hover effects each frame.
func _process(delta: float) -> void:
	update_button_transform()

# Animate the buttons when the cursor hovers over them.
func update_button_transform():
	for button in title_screen_buttons:
		button_hover(button, 0.8, 0.2)


# Update button tween values while the cursor is hovering.
func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset_ratio = Vector2(0.5, 0.5)
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

# Create a tween to animate a property on a button.
func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)



# Load the selected save slot and restore to the saved scene and position.
func _load_save_slot(slot: int) -> void:
	# Hide the save screen before loading the game
	Global.game_controller.load_save_slot(slot)
	print("Game Loaded from Slot %d!" % (slot + 1))
	visible = !visible

func _on_save_1_button_pressed() -> void:
	_load_save_slot(0)

func _on_save_2_button_pressed() -> void:
	_load_save_slot(1)

func _on_save_3_button_pressed() -> void:
	_load_save_slot(2)

func _on_save_4_button_pressed() -> void:
	_load_save_slot(3)

func _on_back_button_pressed() -> void:
	get_tree().reload_current_scene()
