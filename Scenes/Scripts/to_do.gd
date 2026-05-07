extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Dialogic.VAR.Order.EthanOrder:
		$PanelContainer/MarginContainer/VBoxContainer/Body.text = "Bring that weird guy 2 Lavender and a Datura"
	elif Dialogic.VAR.Order.IalOrder:
		$PanelContainer/MarginContainer/VBoxContainer/Body.text = "Bring Ial ???"
	elif Dialogic.VAR.Order.VeronicaOrder:
		if Dialogic.VAR.SceneFinish.MetVeronica:
			$PanelContainer/MarginContainer/VBoxContainer/Body.text = "Bring Veronica 2 crocus flowers and a morning glory"
		else:
			$PanelContainer/MarginContainer/VBoxContainer/Body.text = "Bring the tall woman 2 crocus flowers and a morning glory"
