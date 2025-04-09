extends Node

@onready var SelSequence: Array[String]

@export var Sequence: Array[String]
@export var Duds: Array[String]

@onready var label = $Selected
@onready var buttons = $CenterContainer/ButtonsParent

@onready var submit = $Control/HBoxContainer/Submit
@onready var reset = $Control/HBoxContainer/Reset

func Clear():
	label.text = "Selected: "
	
	for child in buttons.get_children():
		buttons.remove_child(child)
		
func Submit():
	if SelSequence == Sequence:
		print("Correct")
	else:
		print("Wrong")
	
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
		button.size_flags_vertical = Control.SIZE_SHRINK_CENTER  # Ensures proper size
		button.custom_minimum_size = Vector2(120, 35)  # Adjusted size for better UI
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
	
func _ready() -> void:
	Initialize()
