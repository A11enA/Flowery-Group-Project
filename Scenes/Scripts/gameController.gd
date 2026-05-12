class_name  GameControl extends Node

@export var scene_holder : Node

@export var translation_controller : Control

var current_scene
var current_scene_path: String = "res://Scenes/title_screen.tscn"
var player_spawn_position: Vector2 = Vector2(0,2)

func _ready():
	# Store the controller singleton for global access.
	Global.game_controller = self
	
	current_scene = $"World/Title Screen"
	print("scene holder: ", scene_holder)
	
	
# Save the current game state to the specified slot.
func save_current_slot(slot: int = 0) -> Error:
	SAVE_MANAGER.change_slot(slot)
	var err: Error = await SAVE_MANAGER.save_data()
	if err == OK:
		Global.UI_manager.alert("Game Saved")
	return err

# Load saved game data from the specified slot and restore the scene.
func load_save_slot(slot: int = 0) -> void:
	SAVE_MANAGER.change_slot(slot)
	SAVE_MANAGER.load_data()
	var saved_scene = SAVE_MANAGER.get_data("current_scene", "res://Scenes/Village.tscn")
	change_scene(saved_scene, true, false, false, true)
	Global.UI_manager.alert("Game Loaded")

# Load the current save and restart the last loaded scene.
func load_game() -> void:
	if current_scene_path != "":
		change_scene(current_scene_path)
	SAVE_MANAGER.load_data()
	Global.UI_manager.alert("Game Loaded")

func change_scene(
	new_scene: String,
	delete: bool = true,
	keep_running:bool = false,
	transition: bool = false,
	skip_auto_save: bool = false,
	#transition_in: String = "Fade In",
	#transition_out: String = "Fade Out",
	#seconds: float = 1.0
	):
	
	# Auto-save before changing scenes (unless skipped during load operations)
	if not skip_auto_save && current_scene_path != "res://Scenes/title_screen.tscn" && current_scene_path != "":
		await save_current_slot(0)
	
	#fade to black
	#if transition:
		#translation_controller.transition(translation_in, seconds)
		#await translation_controller.animation_player.animation_finished
		
	if current_scene != null:
		if delete:
			scene_holder.remove_child(current_scene)  # Remove immediately from tree
			current_scene.queue_free()  # Clean up in background
		elif keep_running:
			current_scene.visible = false  # hide scene but keep running
		else:
			scene_holder.remove_child(current_scene)  # keeps scene in memory not running
	var new = load(new_scene).instantiate()
	print("new scene: ", new_scene)
	print("scene holder: ", scene_holder)
	scene_holder.add_child(new)
	current_scene = new
	current_scene_path = new_scene
	
	if new_scene == "res://Scenes/Village.tscn":
		Dialogic.start("thoughts")
	##fade back in
	#if transition:
		#translation_controller.transition(transition_out, seconds)
		#await translation_controller.animation_player.animation_finished
	
