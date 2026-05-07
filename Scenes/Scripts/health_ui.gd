extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_display(hp):
	$PanelContainer/HBoxContainer/HealthLabel.text = str(hp)


func _on_pause_ui_health_u():
	update_display(Global.player_hp)
