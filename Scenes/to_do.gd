extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Dialogic.VAR.Order.EthanOrder:
		$"To do".text = "Bring that weird guy 2 Lavender and a Datura"
	elif Dialogic.VAR.Order.IalOrder:
		$"To do".text = "Bring Ial guy ???"
	elif Dialogic.VAR.Order.VeronicaOrder:
		if Dialogic.VAR.Order.SceneFinish.MetVeronica:
			$"To do".text = "Bring Veronica a"
		else:
			$"To do".text = "Bring the tall woman ???"
