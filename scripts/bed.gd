extends CanvasLayer

enum Letter { C, A, L, M }

var TIMES_NEEDED = 5
var times_written_calm = 0
var next_letter: Letter = Letter.C


func _ready() -> void: 
	%BedWithDog.play("asleep")
	%DogComfortCooldownTimer.start(5)
	
	pulse_tip()


func _process(_delta: float) -> void:
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
					
					OS.delay_msec(50)
					%CButton.disabled = false
					%AButton.disabled = false
					%LButton.disabled = false
					%MButton.disabled = false
					
		if times_written_calm == TIMES_NEEDED:
			times_written_calm = 0
			Globals.dog_distressed = false
			
			%BedWithDog.play("asleep")
			%ComfortMinigame.visible = false
			

func pulse_tip():
	var tween: Tween = create_tween()
	tween.set_loops()
	
	tween.tween_property(%DogTip, "modulate:a", 0.4, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(%DogTip, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _on_dog_comfort_cooldown_timer_timeout() -> void:
	%BedWithDog.play("awake")
	%ComfortMinigame.visible = true
	Globals.dog_distressed = true

	%DogComfortDeadline.start(18 + randf() * 7)
	%DogComfortCooldownTimer.start(25 + randf() * 20)


func _on_dog_comfort_deadline_timeout() -> void:
	if Globals.dog_distressed == true:
		Globals.lost_to = Globals.Enemy.DAD
