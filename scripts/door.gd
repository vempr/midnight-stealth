extends CanvasLayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_door") && visible == true:
		if %DoorClosed.visible == false:
			Globals.door_closed = true
			%DoorClosed.visible = true
			%CloseDoor.play()
		else:
			Globals.door_closed = false
			%DoorClosed.visible = false
			%OpenDoor.play()
