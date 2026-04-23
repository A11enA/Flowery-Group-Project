extends CharacterBody2D
class_name Player

@export var move_speed: float = 100.0
@export var acceleration: float = 100.0
@export var sprint = 1.5
@onready var iventory = $NinePatchRect/GridContainer
var direction 
var is_attacking: bool = false

var inventory : Inventory = Inventory.new()

func _ready() -> void:
	Global.player_hp = 3
	$Weapon.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()


func _physics_process(delta: float) -> void:
	#var move_vector: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	if not is_attacking:#velocity = move_vector * move_speed
		move_player()
	move_and_slide()
	
func move_player():
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#velocity = move_vector * move_speed
	velocity = velocity.move_toward(move_vector * move_speed, acceleration)
	
	
	
	if velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("walk_left")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("walk_down")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("walk_up")
	else:
		$AnimatedSprite2D.stop()
	
	if Input.is_action_just_pressed("inv"):
		
		$Inv_UI.visible = !$Inv_UI.visible
		
	


func die():
	$DeathTimer.start()
	$Popup.show_message("you died :(")
	await $DeathTimer.timeout
	get_tree().call_deferred("reload_current_scene")

func on_item_picked_up(item : Item):
	print("I picked up a ", item.name)
	$Popup.show_message("you picked up a flower!")
	inventory.add_item(item)

func _on_hit_box_body_entered(body: Node2D) -> void:
	Global.player_hp -= 1
	print(Global.player_hp)
	#die function 
	if Global.player_hp <= 0:
		die()

func _on_weapon_area_body_entered(body: Node2D) -> void:
	Global.enemy_hp -= 1
	print(Global.enemy_hp)
	if Global.enemy_hp <= 0:
		Global.inventory_manager.addToInventory(1)
		print("wings has been added to your inventory")
		$Popup.show_message("you earned butterfly wings!")
		body.queue_free()

func attack():
		is_attacking = true
		velocity = Vector2.ZERO
		#show the weapon, somewhere hide the weapon
		#turn collision on and off
		$Weapon.visible = true
		%Weapon_area.monitoring = true
		$WeaponTimer.start()
		var player_animation: String = $AnimatedSprite2D.animation
		if player_animation == "walk_right":
			$AnimationPlayer.play("attack_right")
		if player_animation == "walk_left":
			$AnimationPlayer.play("attack_left")
		if player_animation == "walk_down":
			$AnimationPlayer.play("attack_down")
		if player_animation == "walk_up":
			$AnimationPlayer.play("attack_up")
	
func _on_weapon_timer_timeout() -> void:
	is_attacking = false
	$Weapon.visible = false
	%Weapon_area.monitoring = false
