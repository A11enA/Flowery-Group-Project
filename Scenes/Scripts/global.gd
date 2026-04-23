extends Node

var game_controller : GameControl
var inventory_manager : InventoryControl
var player_start_position: Vector2
#var player_spawn_position: Vector2 = Vector2(144,200)
var player_hp = 3
var enemy_hp = 3
var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#score = 0
	#$"MoneyUI".update_score(score)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
