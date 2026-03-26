extends Control

@export var sunFlower = TextureRect

var loading = ["Loading","Loading.","Loading..","Loading..."]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func label_update(text):
	$".".text = str(text)

func _on_timer_timeout() -> void:
	var index = loading.find($".".text,0)
	var newIndex = index + 1
	
	if newIndex == loading.size():
		newIndex = 0
	
	label_update(loading[newIndex])
