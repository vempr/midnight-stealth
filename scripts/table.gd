extends CanvasLayer


func _process(_delta: float) -> void:
	if Globals.door_closed == false:
		%TableDoorClosed.visible = false
	else:
		%TableDoorClosed.visible = true
