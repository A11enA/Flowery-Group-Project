extends Area2D

@export var attributes : flower_attributes
var value: float
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var sound : AudioStreamPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	value = attributes.value
	sprite.texture = attributes.texture

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animation.play()
