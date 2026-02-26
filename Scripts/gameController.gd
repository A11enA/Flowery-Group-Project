class_name  GameControl extends Node

@export var scene_holder : Node

@export var translation_controller : Control

var current_scene


func _ready():
	Global.game_controller = self
	
	current_scene = $"World/Title Screen"
	
	

func change_scene(
	new_scene: String,
	delete: bool = true,
	keep_running:bool = false,
	transition: bool = false,
	transition_in: String = "Fade In",
	transition_out: String = "Fade Out",
	seconds: float = 1.0):
	
	#fade to black
	if transition:
		translation_controller.transition(transition_in, seconds)
		await translation_controller.animation_player.animation_finished
		
	if current_scene != null:
		if delete:
			current_scene.queue_free() # remove scene
		elif keep_running:
			current_scene.visible = false # hide scene but keep running
		else:
			scene_holder.remove_child(current_scene) #keeps scene in memory not running
	var new = load(new_scene).instantiate()
	scene_holder.add_child(new)
	current_scene = new
	
	#fade back in
	if transition:
		translation_controller.transition(transition_out, seconds)
		await translation_controller.animation_player.animation_finished
	
