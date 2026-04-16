extends CharacterBody2D

func _on_interact_body_entered(body: Node2D) -> void:
	if body is Player:
		$Button.visible = true

func _on_interact_body_exited(body: Node2D) -> void:
	if body is Player:
		$Button.visible = false

func _on_button_pressed() -> void:
	if Dialogic.VAR.SceneFinish.tutorialCompleted == false:
		Dialogic.start("Tutorial")
