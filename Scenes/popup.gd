extends Control

func show_message(text):
	print("hello???")
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
