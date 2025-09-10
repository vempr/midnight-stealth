extends Node2D

func _ready() -> void:
	%MainMenu.start_game.connect(_on_start_game)
	%BlackBackground.modulate.a = 0.0
	

func _on_start_game() -> void:
	%BlackBackgroundCL.visible = true
	var tween_in: Tween = create_tween()
	tween_in.tween_property(%BlackBackground, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	await tween_in.finished
	
	var actual_game_instance = preload("res://scenes/actual_game.tscn").instantiate()
	add_child(actual_game_instance)

	%MainMenu.visible = false
	var tween_out: Tween = create_tween()
	tween_out.tween_property(%BlackBackground, "modulate:a", 0.0, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	await tween_out.finished
	
	%BlackBackgroundCL.visible = false
