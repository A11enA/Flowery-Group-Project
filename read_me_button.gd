extends Button

func _on_interact_body_entered(body: Node2D) -> void:
	if body is Player:
		%ReadMeButton.visible = true

func _on_interact_body_exited(body: Node2D) -> void:
	if body is Player:
		%ReadMeButton.visible = false

func _on_pressed() -> void:
	Dialogic.start("testtest")
