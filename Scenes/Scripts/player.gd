extends CharacterBody2D
class_name Player

@export var move_speed: float = 100.0
@export var acceleration: float = 100.0
@export var sprint = 1.5
@onready var iventory = %Inv_UI
var direction 
var is_attacking: bool = false
signal health

var inventory : Inventory = Inventory.new()

# Initialize player state and connect the save/load callbacks.
func _ready() -> void:
	Global.player_hp = 3
	$Weapon.visible = false
	SAVE_MANAGER.data_is_saving.connect(_save_game_state)
	SAVE_MANAGER.data_was_loaded.connect(_load_game_state)

# Handle frame-based input and health regeneration.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		if Global.inventory_manager.find_stack(0):
			attack()
	if Global.player_hp <= 3 && $HealTimer.is_stopped:
		$HealTimer.start()
	
	_handle_save_input()


# Apply physics-based movement while the player is not attacking.
func _physics_process(delta: float) -> void:
	if not is_attacking:
		move_player()
	move_and_slide()

# Calculate movement velocity and play the correct animation.
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
	


# Check save/load input keys and defer a clean save sequence.
func _handle_save_input() -> void:
	if Input.is_action_just_pressed("Save"):
		call_deferred("_save_current_game")
	if Input.is_action_just_pressed("MainMenu"):
		call_deferred("_save_and_return_to_menu")

# Save the current slot and report success or failure.
func _save_current_game() -> void:
	var err: Error = await Global.game_controller.save_current_slot()
	if err == OK:
		print("Game Saved Successfully!")
	else:
		printerr("Save failed:", err)

# Save the game then return to the title screen.
func _save_and_return_to_menu() -> void:
	var err: Error = await Global.game_controller.save_current_slot()
	if err != OK:
		printerr("Save failed:", err)
	get_tree().reload_current_scene()

# Store the player-related state in the save resource before writing to disk.
func _save_game_state() -> void:
	SAVE_MANAGER.set_data("player_position", position)
	SAVE_MANAGER.set_data("player_hp", Global.player_hp)
	SAVE_MANAGER.set_data("enemy_hp", Global.enemy_hp)
	SAVE_MANAGER.set_data("inventory", Global.inventory_manager.inventory)
	SAVE_MANAGER.set_data("Dialogic Variables", Global.inventory_manager.inventory)
	SAVE_MANAGER.set_data("current_scene", Global.game_controller.current_scene_path)

# Restore the player-related state from the save resource after loading.
func _load_game_state() -> void:
	position = SAVE_MANAGER.get_data("player_position", position)
	Global.player_hp = SAVE_MANAGER.get_data("player_hp", Global.player_hp)
	Global.enemy_hp = SAVE_MANAGER.get_data("enemy_hp", Global.enemy_hp)

# Restart the last loaded scene and reload save data when the player dies.
func die():
	Global.game_controller.load_game()

# Add an item to the player's inventory when picked up.
func on_item_picked_up(item : Item):
	print("I picked up a ", item.name)
	inventory.add_item(item)

# Reduce HP when hit and trigger death if health reaches zero.
func _on_hit_box_body_entered(body: Node2D) -> void:
	Global.player_hp -= 1
	print(Global.player_hp)
	health.emit()
	$hpMinus.play()
	if Global.player_hp <= 0:
		die()

# Handle enemy collision when the weapon hits a target.
func _on_weapon_area_body_entered(body: Node2D) -> void:
	Global.enemy_hp -= 1
	print(Global.enemy_hp)
	$bugScream.play()
	if Global.enemy_hp <= 0:
		Global.inventory_manager.addToInventory(1)
		print("wings have been added to your inventory")
		$bugDie.play()
		body.queue_free()

# Begin the attack animation and enable weapon hit detection.
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
	
# Reset attack state when the weapon timer finishes.
func _on_weapon_timer_timeout() -> void:
	is_attacking = false
	$Weapon.visible = false
	%Weapon_area.monitoring = false

# Increase player health when the heal timer completes.
func _on_heal_timer_timeout():
	$hpPlus.play()
	Global.player_hp += 1
	health.emit()
