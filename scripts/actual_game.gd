extends Node2D

var triggered_loss: bool = false
var game_win: bool = false
var dad_danger_zone: bool = false
var mom_danger_zone: bool = false


func _ready() -> void:
	%HUD.process_mode = Node.PROCESS_MODE_INHERIT
	set_process(true)
	%Bed.game_win.connect(_on_game_win)
	%HUD.suffocated.connect(_on_suffocated)
	
	%AmbienceHorror.play()
	%DogSnore.volume_db = -30.0
	%DogPant.volume_db = -15.0
	%Boo.volume_db = -25.0
	%DogSnore.play()
	
	%DadCooldown.start(Globals.functions["getDadCooldown"].call())
	%MomCooldown.start(Globals.functions["getMomCooldown"].call())


func _process(_delta: float) -> void:
	if Globals.door_closed == false && dad_danger_zone == true && triggered_loss == false:
		game_lost(Globals.Enemy.DAD)
	
	if triggered_loss == false:
		if Globals.dog_distressed == true:
			%DogSnore.stop()
			if %DogPant.playing == false:
				%DogPant.play()
		else:
			if %DogSnore.playing == false:
				%DogSnore.play()
			%DogPant.stop()
	
	if Globals.lost_to != Globals.Enemy.NOTHING && triggered_loss == false:
		game_lost(Globals.lost_to)
	
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
	$"../BlackBackgroundCL/BlackBackground/ReplayButton".visible = true
	$"../BlackBackgroundCL/BlackBackground/MainMenuButton".visible = true
	
	var tween: Tween = create_tween()
	tween.tween_property(black_background, "modulate:a", 1.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	for child in %Audios.get_children():
		if child is AudioStreamPlayer:
			tween.parallel().tween_property(child, "volume_db", -80.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			
	await tween.finished
	
	for child in %Audios.get_children():
		if child is AudioStreamPlayer:
			child.queue_free()


func game_lost(lost_to: Globals.Enemy) -> void:
	triggered_loss = true
	
	match lost_to:
		Globals.Enemy.DAD:
			%DadJumpscare.visible = true
			$"../BlackBackgroundCL/BlackBackground/LostToDadLabel".visible = true
		Globals.Enemy.MOM:
			%MomJumpscare.visible = true
			$"../BlackBackgroundCL/BlackBackground/LostToMomLabel".visible = true
			%FootstepsMomFast.play()
			await get_tree().create_timer(2.0).timeout
		Globals.Enemy.TIME:
			%DadJumpscare.visible = true
			$"../BlackBackgroundCL/BlackBackground/LostToTimeLabel".visible = true
			%FootstepsDadFast.play()
			await get_tree().create_timer(2.0).timeout
		Globals.Enemy.OXYGEN:
			$"../BlackBackgroundCL/BlackBackground/LostToOxygenLabel".visible = true
		
	if lost_to != Globals.Enemy.OXYGEN:
		%AmbienceHorror.stop()
		%DogSnore.stop()
		%DogPant.stop()
		%FootstepsDadSlow.stop()
		%FootstepsMomSlow.stop()
		%FootstepsDadFast.stop()
		%FootstepsMomFast.stop()
		%Boo.play(0.5)
		%Jumpscare.visible = true
		await get_tree().create_timer(5.0).timeout
		
	set_process(false)
	%HUD.process_mode = Node.PROCESS_MODE_DISABLED
	
	var black_background_canvas_layer = $"../BlackBackgroundCL"
	var black_background = $"../BlackBackgroundCL/BlackBackground"
	
	black_background_canvas_layer.visible = true
	$"../BlackBackgroundCL/BlackBackground/ReplayButton".visible = true
	$"../BlackBackgroundCL/BlackBackground/MainMenuButton".visible = true
	
	var tween: Tween = create_tween()
	tween.tween_property(black_background, "modulate:a", 1.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	for child in %Audios.get_children():
		if child is AudioStreamPlayer:
			tween.parallel().tween_property(child, "volume_db", -80.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			
	await tween.finished
	
	for child in %Audios.get_children():
		if child is AudioStreamPlayer:
			child.queue_free()


func _on_suffocated() -> void:
	game_lost(Globals.Enemy.OXYGEN)


func _on_clock_timeout() -> void:
	Globals.time += 1
	if Globals.time == 6:
		game_lost(Globals.Enemy.TIME)
	elif Globals.time % 2 == 0:
		%AmbienceClock.play()
	
	%Clock.start(Globals.CLOCK_SPEED)


func _on_dad_cooldown_timeout() -> void:
	%DadReactionTime.start(5)
	
	var tween: Tween = create_tween()
	%FootstepsDadSlow.play()
	tween.tween_property(%FootstepsDadSlow, "volume_db", -10.0, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _on_dad_reaction_time_timeout() -> void:
	dad_danger_zone = true
	%DadWaitTime.start(3)


func _on_dad_wait_time_timeout() -> void:
	dad_danger_zone = false
	
	var tween: Tween = create_tween()
	tween.tween_property(%FootstepsDadSlow, "volume_db", -30.0, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished
	%FootstepsDadSlow.stop()
	
	%DadCooldown.start(Globals.functions["getDadCooldown"].call())


#func _on_mom_cooldown_timeout() -> void:
	#%MomReactionTime.start(4)
	## play walk sfx fade-in
#
#
#func _on_mom_reaction_time_timeout() -> void:
	#mom_danger_zone = true
	#%MomWaitTime.start(5)
	## stop walk sfx abruptly
#
#
#func _on_mom_wait_time_timeout() -> void:
	#mom_danger_zone = false
	## play walk sfx fade-out
	## await 3s
	## stop walk sfx
	#%MomCooldown.start(Globals.functions["getMomCooldown"].call())
