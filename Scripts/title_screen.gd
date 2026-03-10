extends MarginContainer

var tween:Tween


func _ready() -> void:
	var button_group = get_tree().get_nodes_in_group("buttons")
	for button in button_group: 
		button.pivot_offset_ratio = Vector2(0.5, 0.5)



func _process(delta: float) -> void:
	pass

# attach code to button group for tweening

func kill_tween(button) -> void:
	if tween: tween.kill()
	button.scale = Vector2(0.9, 0.7)
	

func _on_optionbutton_pressed():
	var button = %optionButton
	
	kill_tween(button)
	

func start_tween(button) -> void:
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(button, "scale", Vector2(1,1), 0.25)


func _on_option_button_button_up() -> void:
	var button = %optionButton
	start_tween(button)


func _on_start_button_pressed() -> void:
	var button = %loadButton
	kill_tween(button)
	
func _on_start_button_button_up() -> void:
	var button = %loadButton
	start_tween(button)
func _on_credit_button_pressed() -> void:
	var button = %creditButton
	kill_tween(button)

func _on_credit_button_button_up() -> void:
	var button = %creditButton
	start_tween(button)
