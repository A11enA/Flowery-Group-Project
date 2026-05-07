extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkToDo()

func checkToDo():
	if Dialogic.VAR.Order.EthanOrder:
		$MarginContainer/VBoxContainer/Body.text = "Bring that weird guy 2 Lavender and a Datura"
	elif Dialogic.VAR.Order.IalOrder:
		$MarginContainer/VBoxContainer/Body.text = "Bring Ial 2 Tulips and a Digitalis"
	elif Dialogic.VAR.Order.VeronicaOrder:
		if Dialogic.VAR.SceneFinish.MetVeronica:
			$MarginContainer/VBoxContainer/Body.text = "Bring Veronica 2 Crocus flowers and a Morning glory"
		else:
			$MarginContainer/VBoxContainer/Body.text = "Bring the tall woman 2 Crocus flowers and a Morning glory"
	else:
		makeDefault()

func makeDefault():
	$MarginContainer/VBoxContainer/Header.text = "TO DO:"
	$MarginContainer/VBoxContainer/Body.text = "Nothing Yet!"

func itemDisc(id : int):
	if $MarginContainer/VBoxContainer/Header.text == "TO DO:":
		if Global.inventory_manager.find_stack(2):
			$MarginContainer/VBoxContainer/Header.text = "Daisy"
			$MarginContainer/VBoxContainer/Body.text = "Flower with white rays and a yellow center."
		elif Global.inventory_manager.find_stack(3):
			$MarginContainer/VBoxContainer/Header.text = "Sunflower"
			$MarginContainer/VBoxContainer/Body.text = "Flower with white rays and a yellow center."
		elif Global.inventory_manager.find_stack(4):
			$MarginContainer/VBoxContainer/Header.text = "Dandelion"
			$MarginContainer/VBoxContainer/Body.text = "Hardy, perennial herb with a bright yellow flower head."
		elif Global.inventory_manager.find_stack(5):
			$MarginContainer/VBoxContainer/Header.text = "Tulip"
			$MarginContainer/VBoxContainer/Body.text = "Large, cup-shaped flowers that appear in almost all colors. \n Grows pink in this area."
		elif Global.inventory_manager.find_stack(6):
			$MarginContainer/VBoxContainer/Header.text = "Lavender"
			$MarginContainer/VBoxContainer/Body.text = "Fragrant, evergreen, semi-woody shrub recognized via scent and purple, tubular flowers."
		elif Global.inventory_manager.find_stack(7):
			$MarginContainer/VBoxContainer/Header.text = "Digitalis"
			$MarginContainer/VBoxContainer/Body.text = "Tall, tubular medicinal flower \n Often known as Foxglove."
		elif Global.inventory_manager.find_stack(8):
			$MarginContainer/VBoxContainer/Header.text = "Morning Glory"
			$MarginContainer/VBoxContainer/Body.text = "Twining herbaceous annual vines known for their heart-shaped \n leaves and trumpet-shaped flowers that bloom \n in the morning and fade by afternoon."
		elif Global.inventory_manager.find_stack(9):
			$MarginContainer/VBoxContainer/Header.text = "Datura"
			$MarginContainer/VBoxContainer/Body.text = "Flower with white rays and a yellow center."
		elif Global.inventory_manager.find_stack(10):
			$MarginContainer/VBoxContainer/Header.text = "Poppy"
			$MarginContainer/VBoxContainer/Body.text = "Flower with white rays and a yellow center."
		elif Global.inventory_manager.find_stack(11):
			$MarginContainer/VBoxContainer/Header.text = "Crocus"
			$MarginContainer/VBoxContainer/Body.text = "Flower with white rays and a yellow center."
	else:
		checkToDo()
