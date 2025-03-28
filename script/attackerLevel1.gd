extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# The correct SQL injection for this level
var correct_injection = "OR'1'='1';"
var correct_injection2 = "OR'2'='2';"
# Attempt tracking
var attempt_count = 0


func _on_goBack_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")

# UI Elements
@onready var input_field = $InputField
@onready var feedback_label = $FeedbackLabel
@onready var hint_label = $HintLabel  # New hint label

# When submit is pressed, validate the input
func _on_submitbutton_pressed():
	var user_input = input_field.text.replace(" ", "")  # Get the input from LineEdit
	if user_input == correct_injection or correct_injection2:
		feedback_label.text = "✅ Injection successful! You've hacked into the system."
		# Transition to next level
		#get_tree().change_scene("res://AttackerLevel2.tscn")  # Next level (you'll need to create this next
	else:
		attempt_count += 1
		feedback_label.text = " ❌ Incorrect SQL injection. Attempts: " + str(attempt_count)
		if attempt_count >= 3:
			hint_label.visible = true   # Show hint after 3 failed attempts
			hint_label.text = "💡 Hint: Try using 'OR' to make the condition always TRUE."

# Define the process_input method that will handle the SQL injection input
func process_input(input: String) -> bool:
	# Check if the input matches the correct SQL injection for this level
	if input == correct_injection or input == correct_injection2:
		print("Login bypass successful!")
		return true  # Successful attack
	print("Login failed with input: ", input)
	return false  # Failed attempt
