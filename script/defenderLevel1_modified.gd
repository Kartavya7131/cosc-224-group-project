extends Node

# ✅ List of valid defense strategies
@export var valid_fixes: Array = [
	"Use Prepared Statement",
	"Input Validation",
	"ORM Framework",
	"Least Privilege"
]

var selected_sequence: Array = []
var attempt_count = 0

@onready var question_label = $QuestionLabel
@onready var hint_label = $HintLabel
@onready var feedback_label = $FeedbackLabel
@onready var submit_button = $SubmitButton
@onready var reset_button = $ResetButton
@onready var selected_label = $SelectedLabel
@onready var buttons_parent = $ScrollContainer/ButtonsParent
@onready var next_level_timer = $NextLevelTimer
@onready var go_back_button = $GoBackButton

func _ready():
	hint_label.visible = false
	selected_label.text = "Selected: "
	setup_buttons()
	

func setup_buttons():
	var all_buttons = valid_fixes + [
		"Use String Concatenation",
		"Disable Errors",
		"Trust Admin Input",
		"Client-side Checks Only"
	]
	all_buttons.shuffle()

	for fix in all_buttons:
		var button = Button.new()
		button.text = fix
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.custom_minimum_size = Vector2(250, 50)  # consistent width
		button.clip_text = true  # prevents long labels from overflowing
		button.connect("pressed", Callable(self, "_on_button_pressed").bind(fix))
		buttons_parent.add_child(button)



func _on_button_pressed(text: String):
	if not selected_sequence.has(text):
		selected_sequence.append(text)
	update_selected_label()
	print("Selected: ", selected_sequence)

func update_selected_label():
	selected_label.text = "Selected: " + "   ".join(selected_sequence)

func _on_ResetButton_pressed():
	selected_sequence.clear()
	
	update_selected_label()

func _on_SubmitButton_pressed():
	if selected_sequence.size() == 0:
		return

	var all_valid = true
	for item in selected_sequence:
		if item not in valid_fixes:
			all_valid = false
			break

	if all_valid:
		feedback_label.text = "✅ Success! All selected defenses are valid."
		feedback_label.modulate = Color.GREEN
		get_tree().change_scene_to_file("res://scenes/DefendWin1.tscn")
	else:
		attempt_count += 1
		feedback_label.text = "❌ Incorrect selection. Attempts: " + str(attempt_count)
		feedback_label.modulate = Color.RED
		selected_sequence.clear()
		update_selected_label()

		if attempt_count >= 3:
			hint_label.visible = true
			hint_label.text = "💡 Hint: Avoid relying on tricks like string concat or client-side checks."

func _on_NextLevelTimer_timeout():
	get_tree().change_scene_to_file("res://scenes/DefenderLevel2.tscn")

func _on_GoBackButton_pressed():
	get_tree().change_scene_to_file("res://scenes/DefenderPage.tscn")
