extends Node2D

var game_instance: Node = null


func _ready() -> void:
	%MainMenu.start_game.connect(_on_start_game)
	%BlackBackground.modulate.a = 0.0
	

func _on_start_game() -> void:
	%BlackBackgroundCL.visible = true
	var tween_in: Tween = create_tween()
	tween_in.tween_property(%BlackBackground, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	await tween_in.finished
	
	game_instance = preload("res://scenes/actual_game.tscn").instantiate()
	add_child(game_instance)

	%MainMenu.visible = false
	var tween_out: Tween = create_tween()
	tween_out.tween_property(%BlackBackground, "modulate:a", 0.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	await tween_out.finished
	
	%BlackBackgroundCL.visible = false
	%ReplayButton.disabled = false


func reset() -> void:
	game_instance.queue_free()
	Globals.functions["reset_game_state"].call()


func hide_game_end_text() -> void:
	%WinLabel.visible = false
	%LostToTimeLabel.visible = false
	%LostToDadLabel.visible = false
	%LostToMomLabel.visible = false
	%LostToOxygenLabel.visible = false
	%ReplayButton.visible = false
	%MainMenuButton.visible = false



func _on_replay_button_pressed() -> void:
	%ReplayButton.disabled = true
	reset()
	hide_game_end_text()
	_on_start_game()


func _on_main_menu_button_pressed() -> void:
	reset()
	$MainMenu.visible = true
	
	var tween: Tween = create_tween()
	tween.tween_property(%BlackBackground, "modulate:a", 0.0, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	%BlackBackgroundCL.visible = false
	
	hide_game_end_text()
