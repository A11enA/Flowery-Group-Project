extends Node2D

# the label is using a unique name so we can access it with just %
@onready var player_clicks = %PlayerClicksLabel 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#when the scene starts, load in the player clicks from the global script PlayerStats
	player_clicks.text = str(PlayerStats.player_clicks)


func _on_button_pressed():
	Global.game_controller.change_scene("res://Scenes/level_1.tscn")
	#increase 
	PlayerStats.increase_clicks()
	player_clicks.text = str(PlayerStats.player_clicks)
