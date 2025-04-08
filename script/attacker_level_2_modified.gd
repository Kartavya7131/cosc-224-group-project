extends Node

# ✅ Correct sequence to solve the challenge
@export var correct_sequence: Array = ["UNIONSELECTid", "username","password FROMusers;"]

# Stores player-selected sequence
var selected_sequence: Array = []
var attempt_count = 0

# UI Elements
@onready var question_label = $QuestionLabel
@onready var hint_label = $HintLabel
@onready var feedback_label = $FeedbackLabel
@onready var submit_button = $SubmitButton
@onready var reset_button = $ResetButton
@onready var selected_label = $SelectedLabel  
@onready var buttons_parent = $ButtonsParent
@onready var next_level_timer = $NextLevelTimer
@onready var go_back_button = $GoBackButton

func _ready():
	hint_label.visible = false
	selected_label.text = "Selected: "  # Initialize empty
	setup_buttons()

#  Creates buttons dynamically from the correct sequence and distractors
func setup_buttons():
	var all_buttons = correct_sequence + ["SELECT *", "WHERE TABLE = 'users';", "UPDATE users SET"]
	all_buttons.shuffle()

	for sql_fragment in all_buttons:
		var button = Button.new()
		button.text = sql_fragment
		button.size_flags_horizontal = Control.SIZE_EXPAND
		button.size_flags_vertical = Control.SIZE_SHRINK_CENTER  # Ensures proper size
		button.custom_minimum_size = Vector2(100, 25)  # Adjusted size for better UI
		button.connect("pressed", Callable(self, "_on_button_pressed").bind(sql_fragment))
		buttons_parent.add_child(button)

# ✅ When a button is pressed, store the selected value
func _on_button_pressed(button_text: String):
	selected_sequence.append(button_text)
	update_selected_label()
	print("Selected sequence: ", selected_sequence)

# 🔄 Update the selected label with current sequence
func update_selected_label():
	selected_label.text = "Selected: " + "   ".join(selected_sequence)

# 🆕 Reset button clears the selection
func _on_ResetButton_pressed():
	selected_sequence.clear()
	update_selected_label()
	print("Selection reset.")

# 🔎 When Submit is pressed, check the sequence
func _on_SubmitButton_pressed():
	if selected_sequence == correct_sequence:
		feedback_label.text = "✅ Data retrieved! You accessed all user records!"
		feedback_label.modulate = Color.GREEN
		get_tree().change_scene_to_file("res://scenes/AttackWin1.tscn")
	else:
		attempt_count += 1
		feedback_label.text = "❌ Incorrect SQL injection. Attempts: " + str(attempt_count)
		feedback_label.modulate = Color.RED
		selected_sequence.clear()
		update_selected_label()  # Reset display

		if attempt_count >= 3:
			hint_label.visible = true
			hint_label.text = "💡 Hint: Look into UNION SELECT for retrieving multiple query results. or close the string"

# Transition to the next level when timer ends
func _on_NextLevelTimer_timeout():
	get_tree().change_scene_to_file("res://scenes/AttackerLevel3.tscn")

# Go back to AttackerPage
func _on_GoBackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")
