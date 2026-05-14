extends Control


func _ready():
	checkToDo()


func checkToDo():
	print("CHECK TODO RUNNING")
	$MarginContainer/VBoxContainer/Header.set_text("TO DO:")
	
	if Dialogic.VAR.Order.EthanOrder:
		$MarginContainer/VBoxContainer/Body.set_text("Bring that weird guy 2 Lavender and a Datura")
	elif Dialogic.VAR.Order.IalOrder:
		$MarginContainer/VBoxContainer/Body.set_text("Bring Ial 2 Tulips and a Digitalis")
	elif Dialogic.VAR.Order.VeronicaOrder:
		if Dialogic.VAR.SceneFinish.MetVeronica:
			$MarginContainer/VBoxContainer/Body.set_text("Bring Veronica 2 Crocus flowers and a Morning Glory")
		else:
			$MarginContainer/VBoxContainer/Body.set_text("Bring the tall woman 2 Crocus flowers and a Morning Glory")
	
	else:
		makeDefault()


func makeDefault():

	$MarginContainer/VBoxContainer/Header.set_text("TO DO:")
	$MarginContainer/VBoxContainer/Body.set_text("Nothing Yet!")


func itemDisc(id : int):
	
	if id == 0:
		$MarginContainer/VBoxContainer/Header.set_text("Foraging Knife")
		$MarginContainer/VBoxContainer/Body.set_text("Paring knife previously used to cut stems.")
	elif id == 1:
		$MarginContainer/VBoxContainer/Header.set_text("Paper Butterfly Wings")
		$MarginContainer/VBoxContainer/Body.set_text("Wings of the common paper butterfly.\nCan be used as a substitute for paper.")
	elif id == 2:
		$MarginContainer/VBoxContainer/Header.set_text("Daisy")
		$MarginContainer/VBoxContainer/Body.set_text("Flower with white rays and a yellow center.")
	elif id == 3:
		$MarginContainer/VBoxContainer/Header.set_text("Sunflower")
		$MarginContainer/VBoxContainer/Body.set_text("Tall flower that always faces the sun.")
	elif id == 4:
		$MarginContainer/VBoxContainer/Header.set_text("Dandelion")
		$MarginContainer/VBoxContainer/Body.set_text("Hardy, perennial herb with a bright yellow flower head.")
	elif id == 5:
		$MarginContainer/VBoxContainer/Header.set_text("Tulip")
		$MarginContainer/VBoxContainer/Body.set_text("Large, cup-shaped flowers that appear in almost all colors.\nGrows pink in this area.")
	elif id == 6:
		$MarginContainer/VBoxContainer/Header.set_text("Lavender")
		$MarginContainer/VBoxContainer/Body.set_text("Fragrant, evergreen, semi-woody shrub recognized via \nscent and purple tubular flowers.")
	elif id == 7:
		$MarginContainer/VBoxContainer/Header.set_text("Digitalis")
		$MarginContainer/VBoxContainer/Body.set_text("Tall, tubular medicinal flower.\nOften known as Foxglove.")
	elif id == 8:
		$MarginContainer/VBoxContainer/Header.set_text("Morning Glory")
		$MarginContainer/VBoxContainer/Body.set_text("Twining herbaceous annual vine with trumpet-shaped flowers.")
	elif id == 9:
		$MarginContainer/VBoxContainer/Header.set_text("Datura")
		$MarginContainer/VBoxContainer/Body.set_text("Short-lived perennial plant with trumpet-shaped flowers and spiny fruit capsules.")
	elif id == 10:
		$MarginContainer/VBoxContainer/Header.set_text("Poppy")
		$MarginContainer/VBoxContainer/Body.set_text("Flower recognized by vibrant papery petals.")
	elif id == 11:
		$MarginContainer/VBoxContainer/Header.set_text("Crocus")
		$MarginContainer/VBoxContainer/Body.set_text("Purple flowers that produce saffron.")
	else:
		checkToDo()
