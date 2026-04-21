extends CharacterBody2D
#just copied from enemy from past project
@export var speed: float = 150.0
var target: Node2D
@export var hp:int = 3

func _ready() -> void:
	Global.enemy_hp = 3

func _physics_process(delta: float) -> void:
	if target:
		chasing()
	else:
		speed = 150.0
	animate_enemy()
	move_and_slide()

func chasing():
	var distance_to_player: Vector2
	distance_to_player = target.global_position - global_position
	var direction_normal: Vector2 = distance_to_player.normalized()
	if speed > 0.0:
		speed -= 0.1
	velocity = direction_normal * speed
	if target.position.x < position.x:
		$AnimatedSprite2D.scale.x = 1.875
	elif target.position.x > position.x:
		$AnimatedSprite2D.scale.x = -1.875
	


func animate_enemy():
	var normal_velocity: Vector2 = velocity.normalized()
	$AnimatedSprite2D.play("move")
	#if normal_velocity.x > 0.7:
		#$AnimatedSprite2D.play("right")
	#elif normal_velocity.x < -0.7:
		#$AnimatedSprite2D.play("left")
	#elif normal_velocity.y < -0.7:
		#$AnimatedSprite2D.play("up")
	#elif normal_velocity.y > 0.7:
		#$AnimatedSprite2D.play("down")
	#else:
		#$AnimatedSprite2D.play("idle")


func _on_chase_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
	speed = 100
	
func idle():
	pass
