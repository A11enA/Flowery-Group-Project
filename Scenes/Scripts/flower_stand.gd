extends Node2D

var rng = RandomNumberGenerator.new()


func _on_area_2d_body_entered(body):
	if body is Player:
		$"Take Orders".visible = true
		$"Wrap Flowers".visible = true

func _on_area_2d_body_exited(body):
	if body is Player:
		$"Take Orders".visible = false
		$"Wrap Flowers".visible = false




func _on_take_orders_pressed() -> void:
	if Dialogic.VAR.SceneFinish.tutorialCompleted == false:
		Dialogic.start("Tutorial")
	else :
		var randI = rng.randf_range(0, 3)
		if randI <= 1:
			print("1")
		elif randI > 2:
			print("3")
		else:
			print("2") 
	
	

func _on_wrap_flowers_pressed():
	pass # Replace with function body.
