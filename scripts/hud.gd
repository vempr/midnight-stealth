extends CanvasLayer

signal suffocated

const DEPLETE_RATE: float = 1.0 / 60.0
const REFILL_RATE: float = 1.0 / 30.0

var oxygen: float = 1.0
var can_switch: bool = true
var has_suffocated: bool = false


func _ready() -> void:
	%Computer.computer_done.connect(_on_computer_done)


func _process(delta: float) -> void:
	if Globals.time != 0:
		%Time.text = str(Globals.time) + "AM"
			
	if Globals.submitted_assignments == Globals.assignments_to_submit:
		%AssignmentsLeft.visible = false
		%AssignmentsDone.text = str(Globals.assignments_to_submit) + "/" + str(Globals.assignments_to_submit)
		%AssignmentsDone.visible = true
	else:
		%AssignmentsLeft.text = str(Globals.submitted_assignments) + "/" + str(Globals.assignments_to_submit)
	
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
	
	if Globals.door_closed == true:
		oxygen -= DEPLETE_RATE * delta
		if oxygen <= 0.0 && has_suffocated == false:
			has_suffocated = true
			oxygen = 0.0
			suffocated.emit()
	else:
		oxygen += REFILL_RATE * delta
		if oxygen >= 1.0:
			oxygen = 1.0
	
	%OxygenBar.value = oxygen
	


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
