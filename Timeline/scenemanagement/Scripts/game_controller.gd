class_name GameController extends Node

##################################################
###   this is an example of using global scripts to hold information   ####
###   and to allow consistency when changing scenes                    ####
###   this also demonstrates the power of using inherited scenes       ####
###   allowing the setup of a template level that children are derived from
###   global.gd - global scene info, actually trojan horse that calls this script
###   playerstats.gd - global player stats holds all the player info
###   world_2d_template - the template level which level1 and level2 are inheirited from

###  todo: add settings screen, add pause, add music global

@export var scene_holder : Node
@export var transition_controller : Control

var current_scene


# when the script initializes, load itself into the global script
# now this script can be used as a global script by proxy
func _ready():
	Global.game_controller = self
	# initialize the first scene of the game
	current_scene = $World/MainMenu



# change scene
func change_scene(
	new_scene: String, 
	delete: bool = true, #delete the scene true or false
	keep_running: bool = false, #hide the scene true or false
	transition: bool = true, 
	transition_in: String = "Fade In",
	transition_out: String = "Fade Out",
	seconds: float = 1.0):
	
	#fade to black
	if transition:
		transition_controller.transition(transition_in, seconds)
		await transition_controller.animation_player.animation_finished
		
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
		transition_controller.transition(transition_out, seconds)
		await transition_controller.animation_player.animation_finished
