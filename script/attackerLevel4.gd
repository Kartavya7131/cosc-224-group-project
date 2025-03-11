extends Control

var correct_injection = "' OR IF(1=1, SLEEP(5), 0);--"
var attempt_count = 0
var max_attempts = 3

@onready var input_field = $InputField
@onready var feedback_label = $FeedbackLabel
@onready var hint_label = $HintLabel

func _on_goBack_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")
 
func _on_SubmitButton_pressed():
	var user_input = input_field.text.strip_edges()

	if user_input == correct_injection:
		feedback_label.text = "✅ Success! You've detected a blind SQL injection vulnerability!"
		#get_tree().change_scene("res://DefenderLevel1.tscn")
	else:
		attempt_count += 1
		feedback_label.text = "❌ Incorrect! Attempts: " + str(attempt_count)

		if attempt_count >= max_attempts:
			hint_label.visible = true
			hint_label.text = "💡 Hint: Try using a SLEEP function to check response time."
