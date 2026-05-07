extends CanvasLayer

signal healthU

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		$".".visible = !$".".visible


func _on_unpause_pressed():
	get_tree().paused = false
	$".".visible = false


func _on_player_health():
	healthU.emit()
