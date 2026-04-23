extends MarginContainer

@export var save1_button: Button
@export var save2_button: Button
@export var save3_button: Button
@export var save4_button: Button

var title_screen_buttons: Array

func _ready() -> void:
	title_screen_buttons = [save1_button, save2_button, save3_button, save4_button]


func _process(delta: float) -> void:
	update_button_transform()


func update_button_transform():
	for button in title_screen_buttons:
		button_hover(button, 0.8, 0.2)


func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset_ratio = Vector2(0.5, 0.5)
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween. tween_property(button, property, amount, duration)



func _on_save_1_button_pressed() -> void:
	await SAVE_MANAGER.change_slot(0)
	await SAVE_MANAGER.load_data()
	Global.game_controller.change_scene("res://Scenes/Village.tscn")
	print("Game Loaded Successfully!")


func _on_save_2_button_pressed() -> void:
	await SAVE_MANAGER.change_slot(1)
	await SAVE_MANAGER.load_data()
	Global.game_controller.change_scene("res://Scenes/Village.tscn")
	print("Game Loaded Successfully!")


func _on_save_3_button_pressed() -> void:
	await SAVE_MANAGER.change_slot(2)
	await SAVE_MANAGER.load_data()
	Global.game_controller.change_scene("res://Scenes/Village.tscn")
	print("Game Loaded Successfully!")


func _on_save_4_button_pressed() -> void:
	await SAVE_MANAGER.change_slot(3)
	await SAVE_MANAGER.load_data()
	Global.game_controller.change_scene("res://Scenes/Village.tscn")
	print("Game Loaded Successfully!")


func _on_back_button_pressed() -> void:
	Global.game_controller.change_scene("res://Scenes/title_screen.tscn")
