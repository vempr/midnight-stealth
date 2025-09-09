extends CanvasLayer

enum Letter { C, A, L, M }

var TIMES_NEEDED = 5
var times_written_calm = 0
var next_letter: Letter = Letter.C


func _ready() -> void: 
	%Computer.computer_done.connect(_on_computer_done)
	
	%BedWithDog.play("asleep")
	%DogComfortCooldownTimer.start(Globals.functions["getDogComfortCooldownTimer"].call())
	
	pulse_tip()


func _process(_delta: float) -> void:
	if Globals.lost_to != Globals.Enemy.NOTHING:
		%ComfortMinigame.visible = false
	else:
		%TimeLeft.text = str(snapped(%DogComfortDeadline.time_left, 0.1)) + "s"
		%DogTip.text = "(type 'calm' " + str(TIMES_NEEDED - times_written_calm) + "x)"
		
		if Globals.dog_distressed == true:
			match next_letter:
				Letter.C:
					if Input.is_action_just_pressed("press_c"):
						next_letter = Letter.A
						%CButton.disabled = true
				Letter.A:
					if Input.is_action_just_pressed("press_a"):
						next_letter = Letter.L
						%AButton.disabled = true
				Letter.L:
					if Input.is_action_just_pressed("press_l"):
						next_letter = Letter.M
						%LButton.disabled = true
				Letter.M:
					if Input.is_action_just_pressed("press_m"):
						next_letter = Letter.C
						times_written_calm += 1
						%MButton.disabled = true
						
						await get_tree().create_timer(0.05).timeout
						reset_letter_buttons()
						
			if times_written_calm == TIMES_NEEDED:
				times_written_calm = 0
				Globals.dog_distressed = false
				
				%BedWithDog.play("asleep")
				%ComfortMinigame.visible = false


func reset_letter_buttons() -> void:
	%CButton.disabled = false
	%AButton.disabled = false
	%LButton.disabled = false
	%MButton.disabled = false


func pulse_tip():
	var tween: Tween = create_tween()
	tween.set_loops()
	
	tween.tween_property(%DogTip, "modulate:a", 0.4, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(%DogTip, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _on_dog_comfort_cooldown_timer_timeout() -> void:
	%BedWithDog.play("awake")
	%ComfortMinigame.visible = true
	Globals.dog_distressed = true

	%DogComfortDeadline.start(Globals.functions["getDogComfortDeadline"].call())
	%DogComfortCooldownTimer.start(Globals.functions["getDogComfortCooldownTimer"].call())


func _on_dog_comfort_deadline_timeout() -> void:
	if Globals.dog_distressed == true:
		Globals.lost_to = Globals.Enemy.DAD


func _on_computer_done() -> void:
	%SleepButton.visible = true


func _on_sleep_button_pressed() -> void:
	print("game win!")
