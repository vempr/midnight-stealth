extends Node2D

var triggered_loss: bool = false
var game_win: bool = false
var dad_danger_zone: bool = false
var mom_danger_zone: bool = false
var attack_locked: bool = false


func _ready() -> void:
	%HUD.process_mode = Node.PROCESS_MODE_INHERIT
	set_process(true)
	%Bed.game_win.connect(_on_game_win)
	%Bed.failed_to_comfort_dog.connect(_on_failed_to_comfort_dog)
	%HUD.suffocated.connect(_on_suffocated)
	
	%AmbienceHorror.play()
	%DogSnore.volume_db = -30.0
	%DogPant.volume_db = -15.0
	%DogSnore.play()
	
	%DadCooldown.start(Globals.functions["getDadCooldown"].call())
	%MomCooldown.start(Globals.functions["getMomCooldown"].call())


func _process(_delta: float) -> void:
	if Globals.door_closed == false && dad_danger_zone == true && triggered_loss == false:
		game_lost(Globals.Enemy.DAD)
	
	if (Globals.door_closed == true || Globals.laptop_closed == false) && mom_danger_zone == true && triggered_loss == false:
		game_lost(Globals.Enemy.MOM)
	
	if triggered_loss == false:
		if Globals.dog_distressed == true:
			%DogSnore.stop()
			if %DogPant.playing == false:
				%DogPant.play()
		else:
			if %DogSnore.playing == false:
				%DogSnore.play()
			%DogPant.stop()
	
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
			
	process_mode = Node.PROCESS_MODE_DISABLED


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
		Globals.Enemy.OXYGEN:
			$"../BlackBackgroundCL/BlackBackground/LostToOxygenLabel".visible = true
		
	if lost_to == Globals.Enemy.DAD || lost_to == Globals.Enemy.MOM:
		%AmbienceHorror.stop()
		%AmbienceHorror.stop()
		%DogSnore.stop()
		%DogPant.stop()
		%FootstepsDadSlow.stop()
		%FootstepsMomSlow.stop()
		%FootstepsDadFast.stop()
		%FootstepsMomFast.stop()
		
		if lost_to == Globals.Enemy.DAD:
			%BooDad.play(0.5)
		else:
			%BooMom.play(0.5)
			
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
			
	for child in %Timers.get_children():
		if child is Timer:
			child.stop()


func _on_suffocated() -> void:
	if Globals.game_won == true:
		return
	game_lost(Globals.Enemy.OXYGEN)
	
	
func _on_failed_to_comfort_dog() -> void:
	if triggered_loss:
		return
	
	if Globals.game_won == true:
		return
		
	%FootstepsDadFast.play()
	await get_tree().create_timer(2.0).timeout
	game_lost(Globals.Enemy.DAD)
	

func _on_clock_timeout() -> void:
	if Globals.game_won == true:
		return
		
	Globals.time += 1
	if Globals.time == 6:
		game_lost(Globals.Enemy.TIME)
	elif Globals.time % 2 == 0:
		%AmbienceClock.play()
	
	%Clock.start(Globals.CLOCK_SPEED)


func lock_attacks(duration: float) -> void:
	attack_locked = true
	await get_tree().create_timer(duration).timeout
	attack_locked = false


func _on_dad_cooldown_timeout() -> void:
	if triggered_loss || Globals.game_won == true || attack_locked == true:
		return
		
	%DadReactionTime.start(5)
	lock_attacks(10.0)
	
	var tween: Tween = create_tween()
	%FootstepsDadSlow.volume_db = -30.0
	%FootstepsDadSlow.play(1)
	tween.tween_property(%FootstepsDadSlow, "volume_db", -10.0, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _on_dad_reaction_time_timeout() -> void:
	if triggered_loss || Globals.game_won == true:
		return
		
	dad_danger_zone = true
	%DadWaitTime.start(3)


func _on_dad_wait_time_timeout() -> void:
	if triggered_loss || Globals.game_won == true:
		return
		
	dad_danger_zone = false
	
	var tween: Tween = create_tween()
	tween.tween_property(%FootstepsDadSlow, "volume_db", -100.0, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished
	%FootstepsDadSlow.stop()
	
	%DadCooldown.start(Globals.functions["getDadCooldown"].call())


func _on_mom_cooldown_timeout() -> void:
	if triggered_loss || Globals.game_won == true || attack_locked:
		return

	%MomReactionTime.start(4)
	lock_attacks(9.0)
	
	var tween: Tween = create_tween()
	%FootstepsMomSlow.volume_db = -30.0
	%FootstepsMomSlow.play(1)
	tween.tween_property(%FootstepsMomSlow, "volume_db", -10.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _on_mom_reaction_time_timeout() -> void:
	if triggered_loss || Globals.game_won == true:
		return
		
	mom_danger_zone = true
	%MomWaitTime.start(3)
	%FootstepsMomSlow.stop()


func _on_mom_wait_time_timeout() -> void:
	if triggered_loss || Globals.game_won == true:
		return
		
	mom_danger_zone = false
	
	%FootstepsMomSlow.play()
	var tween: Tween = create_tween()
	tween.tween_property(%FootstepsMomSlow, "volume_db", -100.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished
	%FootstepsMomSlow.stop()
	
	%MomCooldown.start(Globals.functions["getMomCooldown"].call())
