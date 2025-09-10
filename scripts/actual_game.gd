extends Node2D

var triggered_loss: bool = false
var game_win: bool = false


func _ready() -> void:
	%HUD.process_mode = Node.PROCESS_MODE_INHERIT
	set_process(true)
	%Bed.game_win.connect(_on_game_win)
	
	%AmbienceHorror.play()
	%DogSnore.volume_db = -30.0
	%DogPant.volume_db = -15.0
	%Boo.volume_db = -15.0
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
	
	if Globals.lost_to != Globals.Enemy.NOTHING && triggered_loss == false:
		triggered_loss = true
		var lost_to_dad: bool = Globals.lost_to == Globals.Enemy.DAD
		
		if lost_to_dad:
			%FootstepsDadFast.play()
		else:
			%FootstepsMomFast.play()
		await get_tree().create_timer(2.0).timeout
		
		%Jumpscare.visible = true
		if lost_to_dad:
			%DadJumpscare.visible = true
		else:
			%MomJumpscare.visible = true
				
		get_tree().paused = true
		%Boo.play(0.5)
	
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


func _on_game_win() -> void:
	set_process(false)
	%HUD.process_mode = Node.PROCESS_MODE_DISABLED
	
	var black_background_canvas_layer = $"../BlackBackgroundCL"
	var black_background = $"../BlackBackgroundCL/BlackBackground"
	var win_label = $"../BlackBackgroundCL/BlackBackground/WinLabel"
	
	black_background_canvas_layer.visible = true
	win_label.visible = true
	
	var tween: Tween = create_tween()
	tween.tween_property(black_background, "modulate:a", 1.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	for child in %Audios.get_children():
		if child is AudioStreamPlayer:
			tween.parallel().tween_property(child, "volume_db", -80.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			
	await tween.finished
	
	for child in %Audios.get_children():
		if child is AudioStreamPlayer:
			child.queue_free()
	
	
	
