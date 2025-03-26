extends Node
@export var answer := ""
	
func checkSolution(input):
	return compressSolution(answer) == compressSolution(input);
	
func compressSolution(string):
	string = string.replace(" ", "")
	string = string.to_lower()
	return string

@onready var input_field = $"../InputField"
func _on_level_check_button_down() -> void:
	var parent = get_parent()
	
	var result = parent.ExecuteQuery(input_field.text)	
	var input = parent.CountRows(result);
	
	if (checkSolution("%s" % input)): # Currently Checking 'select name from users'
		print("Correct Answer")
