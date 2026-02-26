class_name SceneTransitionController extends Control

@export var background : ColorRect
@export var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func transition(animation: String, seconds: float):
	animation_player.play(animation, -1.0, 1/seconds)
