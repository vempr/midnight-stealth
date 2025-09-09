extends CanvasLayer

signal computer_done

const PASSING_GRADE: float = 95.0
const ASSIGNMENTS_TO_SUBMIT: int = 2
const GREEN: Color = Color(0.0, 0.679, 0.0)
const RED: Color = Color(1.0, 0.199, 0.166)

var submitted_assignments: int = 0
var math_percentage: float = 0.0
var english_percentage: float = 0.0
var in_grading_process: bool = false

@onready var math_template_text: String = %MathTextTemplate.placeholder_text
@onready var english_template_text: String = %EnglishTextTemplate.placeholder_text


func _process(_delta: float) -> void:
	if submitted_assignments == ASSIGNMENTS_TO_SUBMIT:
		computer_done.emit()


func compare_two_texts(a: String, b: String) -> float:
	var total_letters_length: int = max(a.length(), b.length())	
	var correct_letters: int = 0
	
	for i in range(total_letters_length):
		if i < a.length() && i < b.length() && a[i] == b[i]:
			correct_letters += 1

	return float(correct_letters) / float(total_letters_length) * 100.0


func _on_math_submit_button_pressed() -> void:
	in_grading_process = true
	var result = compare_two_texts(math_template_text, %MathTextEdit.text)
	in_grading_process = false
	
	if result >= PASSING_GRADE:
		submitted_assignments += 1
		%MathSubmitButton.disabled = true
		%MathSubmitButton.text = "Math Homework Submitted!"
		%MathGrade.add_theme_color_override("font_color", GREEN)
		%Correct.play()
	else:
		%MathGrade.add_theme_color_override("font_color", RED)
		%Wrong.play()
	
	%MathGrade.text = str(snapped(result, 0.1)) + "%"
	%MathGradePrefix.visible = true
	%MathGrade.visible = true

func _on_english_submit_button_pressed() -> void:
	in_grading_process = true
	var result = compare_two_texts(english_template_text, %EnglishTextEdit.text)
	in_grading_process = false
	
	if result >= PASSING_GRADE:
		submitted_assignments += 1
		%EnglishSubmitButton.disabled = true
		%EnglishSubmitButton.text = "English Homework Submitted!"
		%EnglishGrade.add_theme_color_override("font_color", GREEN)
		%Correct.play()
	else:
		%EnglishGrade.add_theme_color_override("font_color", RED)
		%Wrong.play()
		
	%EnglishGrade.text = str(snapped(result, 0.1)) + "%"
	%EnglishGradePrefix.visible = true
	%EnglishGrade.visible = true
