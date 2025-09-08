extends Node2D

func _process(_delta: float) -> void:
	match Globals.lost_to:
		Globals.Enemy.DAD:
			# play running sound
			await get_tree().create_timer(2.0).timeout
			%Jumpscare.visible = true
			%DadJumpscare.visible = true
			
		Globals.Enemy.MOM:
			# play running sound
			await get_tree().create_timer(2.0).timeout
			%Jumpscare.visible = true
			%MomJumpscare.visible = true
	
	match Globals.place:
		Globals.Place.TABLE:
			%Table.visible = true
			%Door.visible = false
			%Bed.visible = false
			%Computer.visible = false
			
		Globals.Place.DOOR:
			%Table.visible = false
			%Door.visible = true
			%Bed.visible = false
			%Computer.visible = false
			
		Globals.Place.BED:
			%Table.visible = false
			%Door.visible = false
			%Bed.visible = true
			%Computer.visible = false
		
		Globals.Place.COMPUTER:
			%Table.visible = false
			%Door.visible = false
			%Bed.visible = false
			%Computer.visible = true
