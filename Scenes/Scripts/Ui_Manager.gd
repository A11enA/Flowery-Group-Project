class_name UIControl
extends Control

signal healthU

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.UI_manager = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func alert(msg: String):
	$popUp.alert(msg)

func itemDisc(id: int):
	print("ITEM DISC RUNNING")
	print("ITEM DISC:", id)
	$ToDo.itemDisc(id)
	$ToDo.visible = true
	visible = true

func check():
	$ToDo.checkToDo()
