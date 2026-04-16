extends Panel

@onready var item_visual: TextureRect = $TextureRect

func set_item(item):
	if item:
		item_visual.texture = item.icon
	else:
		item_visual.texture = null
