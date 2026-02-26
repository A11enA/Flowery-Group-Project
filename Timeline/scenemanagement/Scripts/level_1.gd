extends Node2D

# this is what will display our player's stats in this case button clicks
@onready var player_clicks = %PlayerClicksLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	### this should be taken out of the process
	player_clicks.text = str(PlayerStats.player_clicks)


func _on_button_pressed():
	
	Global.game_controller.change_scene("res://Scenes/level_2.tscn", true, false)
	PlayerStats.increase_clicks()
	player_clicks.text = str(PlayerStats.player_clicks)
