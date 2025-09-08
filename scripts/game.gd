extends Node2D

func _process(_delta: float) -> void:
	match Globals.lost_to:
		Globals.Enemy.DAD:
			# play running sound
			OS.delay_msec(2000)
			%Jumpscare.visible = true
			%DadJumpscare.visible = true
			
		Globals.Enemy.MOM:
			# play running sound
			OS.delay_msec(2000)
			%Jumpscare.visible = true
			%MomJumpscare.visible = true
	
	match Globals.place:
		Globals.Place.TABLE:
			%Table.visible = true
			%Door.visible = false
			%Bed.visible = false
			
		Globals.Place.DOOR:
			%Table.visible = false
			%Door.visible = true
			%Bed.visible = false
			
		Globals.Place.BED:
			%Table.visible = false
			%Door.visible = false
			%Bed.visible = true
		
		Globals.Place.COMPUTER:
			%Table.visible = false
			%Door.visible = false
			%Bed.visible = false
