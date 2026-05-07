extends Control

func _ready():
	visible = false

func alert(msg: String):
	print("alert start")
	$PanelContainer/MarginContainer/VBoxContainer/Body.text = msg
	$".".visible = true
	$Timer.start()
	print("alert end")

func _on_timer_timeout():
	print("timeout start")
	$".".visible = false
	$PanelContainer/MarginContainer/VBoxContainer/Body.text = ""
	print("timeout end")
