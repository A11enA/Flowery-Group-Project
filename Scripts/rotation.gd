extends Control

@export var sunFlower = TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spin(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spin(rotation_length_s: float):
	var tween = create_tween().set_loops()
	tween.tween_property(sunFlower, "rotation", TAU, rotation_length_s).from(0)


func _on_load_button_pressed() -> void:
	pass # Replace with function body.
