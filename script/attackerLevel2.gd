extends Control

var correct_injection = "' UNION SELECT id, username, password FROM users;--"
var attempt_count = 0

func _on_goBack_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")

@onready var input_field = $InputField
@onready var feedback_label = $FeedbackLabel
@onready var hint_label = $HintLabel

func _ready():
	hint_label.visible = false  

func _on_SubmitButton_pressed():
	var user_input = input_field.text.strip_edges()

	if user_input == correct_injection:
		feedback_label.text = "✅ Data retrieved! You accessed all user records!"
		#get_tree().change_scene("res://AttackerLevel3.tscn")
	else:
		attempt_count += 1
		feedback_label.text = "❌ Incorrect! Attempts: " + str(attempt_count)

		if attempt_count >= 3:
			hint_label.visible = true
			hint_label.text = "💡 Hint: UNION SELECT can help retrieve additional data. or close the string"
