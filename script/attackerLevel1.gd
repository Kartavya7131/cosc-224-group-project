extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# The correct SQL injection for this level
var correct_injection = "OR'1'='1';"

# Attempt tracking
var attempt_count = 0


func _on_goBack_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")

# UI Elements
@onready var input_field = $LineEdit
@onready var feedback_label = $FeedbackLabel
@onready var hint_label = $hint_label  # New hint label

# When submit is pressed, validate the input
func _on_submitbutton_pressed():
	var user_input = input_field.text  # Get the input from LineEdit
	if user_input == correct_injection:
		feedback_label.text = "Injection successful! You've hacked into the system."
		# Transition to next level
		#get_tree().change_scene("res://AttackerLevel2.tscn")  # Next level (you'll need to create this next
	else:
		attempt_count += 1
		feedback_label.text = " Incorrect SQL injection. Attempts: " + str(attempt_count)
		if attempt_count >= 3:
			hint_label.visible = true   # Show hint after 3 failed attempts
			hint_label.text = " Hint: Try using 'OR' to make the condition always TRUE."
