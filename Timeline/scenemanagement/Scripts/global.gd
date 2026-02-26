extends Node

### all this global does is bring in the game controller script as a global
var game_controller : GameController
#var player_stats : PlayerStats











####################################################
### CODE BELOW IS FROM A SIMPLER SCENE SWITCHER ####
var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(-1)


func goto_scene(path):
	#you shouldnt change the scene immediately since it might craash
	# defer the change until it is safe
	_deferred_goto_scene.call_deferred(path)
	

func _deferred_goto_scene(path):
	#after all the scene code is finished
	#now it is safe to change the scene
	current_scene.free()
	
	#load new scene
	var s = ResourceLoader.load(path)
	
	#instance the new scene
	current_scene = s.instantiate()
	
	#add it to the current scene, as child of the root
	get_tree().root.add_child(current_scene)
	
	get_tree().current_scene = current_scene
