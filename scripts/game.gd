extends Node2D


func _ready() -> void:
	%AmbienceHorror.play()
	%DogSnore.volume_db = -30.0
	%DogPant.volume_db = -15.0
	%DogSnore.play()


func _process(_delta: float) -> void:
	if Globals.dog_distressed == true:
		%DogSnore.stop()
		if %DogPant.playing == false:
			%DogPant.play()
	else:
		if %DogSnore.playing == false:
			%DogSnore.play()
		%DogPant.stop()
	
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
			
			%DogSnore.volume_db = -30
			%DogPant.volume_db = -15
			
		Globals.Place.DOOR:
			%Table.visible = false
			%Door.visible = true
			%Bed.visible = false
			%Computer.visible = false
			
			%DogSnore.volume_db = -25
			%DogPant.volume_db = -15
			
		Globals.Place.BED:
			%Table.visible = false
			%Door.visible = false
			%Bed.visible = true
			%Computer.visible = false
			
			%DogSnore.volume_db = -20
			%DogPant.volume_db = -10
		
		Globals.Place.COMPUTER:
			%Table.visible = false
			%Door.visible = false
			%Bed.visible = false
			%Computer.visible = true
			
			%DogSnore.volume_db = -35
			%DogPant.volume_db = -15
