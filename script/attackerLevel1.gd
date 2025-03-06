extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# The correct SQL injection for this level
var correct_injection = "OR '1' = '1';--"

# UI Elements
@onready var input_field = $LineEdit
@onready var feedback_label = $FeedbackLabel

# When submit is pressed, validate the input
func _on_SubmitButton_pressed():
	var user_input = input_field.text.strip_edges()  # Get the input from LineEdit
	if user_input == correct_injection:
		feedback_label.text = "Injection successful! You've hacked into the system."
		# Transition to next level
		#get_tree().change_scene("res://AttackerLevel2.tscn")  # Next level (you'll need to create this next)
	else:
		feedback_label.text = "Incorrect SQL injection. Try again!"
