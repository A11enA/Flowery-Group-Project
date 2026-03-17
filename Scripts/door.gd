extends Area2D

@export var next_scene : String
@export var player_location : Vector2

func _on_body_entered(body: Node2D) -> void:
	print("entered")
	if body is Player:
		#SceneManager.player_spawn_position = player_location
		get_tree().change_scene_to_file.call_deferred(next_scene)

func _on_body_exited(body: Node2D) -> void:
	print("exited")
	pass
