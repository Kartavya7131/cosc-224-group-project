extends Control

var correct_injection = "';UPDATEusersSETpassword='hacked'WHEREusername='admin';"
# ✅ Correct sequence to solve the challenge
@export var correct_sequence: Array = ["UPDATEusers", "SETpassword='hacked'","WHEREusername='admin';"]
var attempt_count = 0

@onready var input_field = $InputField
@onready var feedback_label = $FeedbackLabel
@onready var hint_label = $HintLabel

func _on_goBack_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")
 

func _on_SubmitButton_pressed():
	var user_input = input_field.text.replace(" ","")

	if user_input == correct_injection:
		feedback_label.text = "✅ Password changed! You modified the database!"
		#get_tree().change_scene("res://AttackerLevel4.tscn")
	else:
		attempt_count += 1
		feedback_label.text = "❌ Incorrect! Attempts: " + str(attempt_count)

		if attempt_count >= 3:
			hint_label.visible = true
			hint_label.text = "💡 Hint: Try injecting an UPDATE statement. try ending the string first"

# Define the process_input method that will handle the SQL injection input
func process_input(input: String) -> bool:
	# Check if the input matches the correct SQL injection for this level
	if input == correct_injection:
		print("Password modification successful!")
		return true  # Successful attack (SQL injection worked)
	print("Password modification failed with input: ", input)
	return false  # Failed attempt
