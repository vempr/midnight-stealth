extends CanvasLayer

var can_switch := true


func _ready() -> void:
	%Computer.computer_done.connect(_on_computer_done)


func _process(_delta: float) -> void:
	match Globals.place:
		Globals.Place.TABLE:
			%RightPanelArea.visible = true
			%BottomPanelArea.visible = true
			%LeftPanelArea.visible = false
			%BottomPanelAreaDown.visible = false
			
		Globals.Place.DOOR:
			%RightPanelArea.visible = true
			%BottomPanelArea.visible = false
			%LeftPanelArea.visible = true
			%BottomPanelAreaDown.visible = false
			
		Globals.Place.BED:
			%RightPanelArea.visible = false
			%BottomPanelArea.visible = false
			%LeftPanelArea.visible = true
			%BottomPanelAreaDown.visible = false
		
		Globals.Place.COMPUTER:
			%RightPanelArea.visible = false
			%BottomPanelArea.visible = false
			%LeftPanelArea.visible = false
			%BottomPanelAreaDown.visible = true
		


func _on_bottom_panel_area_down_mouse_entered() -> void:
	if can_switch:
		Globals.place = Globals.Place.TABLE
		can_switch = false
		await get_tree().create_timer(0.2).timeout
		can_switch = true


func _on_left_panel_area_mouse_entered() -> void:
	if can_switch:
		if Globals.place == Globals.Place.DOOR:
			Globals.place = Globals.Place.TABLE
			can_switch = false
			await get_tree().create_timer(0.2).timeout
			can_switch = true
		else:
			Globals.place = Globals.Place.DOOR
			can_switch = false
			await get_tree().create_timer(0.2).timeout
			can_switch = true


func _on_right_panel_area_mouse_entered() -> void:
	if can_switch:
		if Globals.place == Globals.Place.DOOR:
			Globals.place = Globals.Place.BED
			can_switch = false
			await get_tree().create_timer(0.2).timeout
			can_switch = true
		else:
			Globals.place = Globals.Place.DOOR
			can_switch = false
			await get_tree().create_timer(0.2).timeout
			can_switch = true


func _on_bottom_panel_area_mouse_entered() -> void:
	if can_switch:
		Globals.place = Globals.Place.COMPUTER
		can_switch = false
		await get_tree().create_timer(0.2).timeout
		can_switch = true


func _on_computer_done() -> void:
	%SleepNotification.visible = true
