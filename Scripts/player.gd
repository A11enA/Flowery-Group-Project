extends CharacterBody2D
class_name Player

@export var move_speed: float = 100.0
@export var acceleration: float = 10.0
@export var sprint = 1.5
@export var inv : InventoryControl
var direction 

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var move_vector: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = move_vector * move_speed

	if Input.is_action_pressed("sprint"):
			velocity *= sprint
	move_and_slide()
