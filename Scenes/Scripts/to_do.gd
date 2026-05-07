extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Dialogic.VAR.Order.EthanOrder:
		$MarginContainer/VBoxContainer/Body.text = "Bring that weird guy 2 Lavender and a Datura"
	elif Dialogic.VAR.Order.IalOrder:
		$MarginContainer/VBoxContainer/Body.text = "Bring Ial 2 Tulips and a Digitalis"
	elif Dialogic.VAR.Order.VeronicaOrder:
		if Dialogic.VAR.SceneFinish.MetVeronica:
			$MarginContainer/VBoxContainer/Body.text = "Bring Veronica 2 Crocus flowers and a Morning glory"
		else:
			$MarginContainer/VBoxContainer/Body.text = "Bring the tall woman 2 Crocus flowers and a Morning glory"
