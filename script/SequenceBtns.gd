extends Node

@onready var SelSequence: Array[String]

@export var Sequence: Array[String]
@export var Duds: Array[String]

@onready var label = $Body/TopBar/MarginContainer/Selected
@onready var buttons = $Body/ScrollContainer/CenterContainer/ButtonsParent

@onready var submit = $Body/Buttons/MarginSubmit/Submit
@onready var reset = $Body/Buttons/MarginReset/Reset

@onready var attempts
var hint
var attempt

var hasOrder = true

func Init(seq : Array[String], duds: Array[String], hintLabel, attemptLabel, order:bool):
	Sequence = seq
	Duds = duds
	
	hint = hintLabel
	
	hasOrder = order
	
	attempt = attemptLabel
	attempts = 0
	attempt.text = "Attempts: %d" % attempts
	
	Initialize()

func Clear():
	label.text = "Selected: "
	
	for child in buttons.get_children():
		buttons.remove_child(child)
		
func Submit():
	if (hasOrder):
		if SelSequence == Sequence:
			print("Correct")
		else:
			print("Wrong")
			Reset()
			
			attempts += 1
			attempt.text = "Attempts: %d" % attempts
			
			if attempts >= 3:
				hint.show()
	else:
		var matches = true
		for item in SelSequence:
			if (!Sequence.has(item)):
				matches = false
				break
		
		if (matches):
			if (SelSequence.size() == Sequence.size()):
				print("Correct")
			else:
				print("Your Missing Some Answers")
		else:
			print("Incorrect")
			
			
	
func Reset():
	SelSequence.clear()
	label.text = "Selected: "

func Initialize():
	Clear()
	print(label.text)
	
	var all_buttons = Sequence + Duds
	all_buttons.shuffle()

	for sql_fragment in all_buttons:
		var button = Button.new()
		button.text = sql_fragment
		button.size_flags_horizontal = Control.SIZE_EXPAND
		button.size_flags_vertical = Control.SIZE_EXPAND
		button.custom_minimum_size = Vector2(135, 40)  # Adjusted size for better 
		button.connect("pressed", Callable(self, "appendSequence").bind(sql_fragment))
		buttons.add_child(button)
		
	submit.connect("button_down", Callable(self, "Submit"))
	reset.connect("button_down", Callable(self, "Reset"))

func update_selected_label():
	label.text = "Selected: " + "   ".join(SelSequence)

# When a button is pressed, store the selected value
func appendSequence(button_text: String):
	SelSequence.append(button_text)
	update_selected_label()
	print("Selected sequence: ", SelSequence)
