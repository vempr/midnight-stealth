extends CanvasLayer


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_laptop") && visible == true:
		Globals.laptop_closed = !Globals.laptop_closed
		if Globals.laptop_closed == true:
			%LaptopPowerOff.play()
			%LaptopPowerOn.stop()
		else:
			%LaptopPowerOff.stop()
			%LaptopPowerOn.play()
			
	if Globals.door_closed == false:
		if Globals.laptop_closed == false:
			%TableDoorOpenLaptopOpen.visible = true
			%TableDoorOpenLaptopClosed.visible = false
			%TableDoorClosedLaptopOpen.visible = false
			%TableDoorClosedLaptopClosed.visible = false
		else:
			%TableDoorOpenLaptopOpen.visible = false
			%TableDoorOpenLaptopClosed.visible = true
			%TableDoorClosedLaptopOpen.visible = false
			%TableDoorClosedLaptopClosed.visible = false
	else:
		if Globals.laptop_closed == false:
			%TableDoorOpenLaptopOpen.visible = false
			%TableDoorOpenLaptopClosed.visible = false
			%TableDoorClosedLaptopOpen.visible = true
			%TableDoorClosedLaptopClosed.visible = false
		else:
			%TableDoorOpenLaptopOpen.visible = false
			%TableDoorOpenLaptopClosed.visible = false
			%TableDoorClosedLaptopOpen.visible = false
			%TableDoorClosedLaptopClosed.visible = true
