extends CharacterBody2D

@export var Interaction: String
@export var Sprite: Texture

func _ready() -> void:
	$Sprite2D.texture = Sprite

func _on_interact_body_entered(body: Node2D) -> void:
	if body is Player:
		$Button.visible = true

func _on_interact_body_exited(body: Node2D) -> void:
	if body is Player:
		$Button.visible = false

func _on_button_pressed() -> void:
	if Interaction == "Ial Order":
		if Dialogic.VAR.SceneFinish.tutorialCompleted == false:
			Dialogic.start("Tutorial")
		else:
			Dialogic.start(Interaction)
	else:
		Dialogic.start(Interaction)
