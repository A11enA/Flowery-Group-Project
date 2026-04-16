extends Resource

class_name InventoryControl

# In your game code
const DATABASE_PATH := "res://data/items/item_database.tres"
var database: ItemDatabase

func _ready() -> void:
	
	database = load(DATABASE_PATH) as ItemDatabase
	print("Loaded %d items" % database.items.size())
	
	
	

func addToInventory(Item) -> void:
	print(Item + " put in inventory")
	#Item_display.Texture = Item.icon

func getStarterWeapon() -> void:
	var knife = database.get_item_by_id(0)
	print(knife.get_translated_name())  # "Health Potion" (translated)
	addToInventory(knife)
	
