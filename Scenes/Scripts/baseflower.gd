extends Area2D

@export var item : Item

var value: float
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var sound : AudioStreamPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# fill the values from our resource
	#energy = item.energy
	sprite.texture = item.texture

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("on_item_picked_up"):
		body.on_item_picked_up(item)
		#PlayerManager.player_hp += energy
		animation.play("eaten")
		
func del_item_onscreen():
	queue_free()
