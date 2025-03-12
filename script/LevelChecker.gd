extends Node
@export var answer := ""
	
func checkSolution(input):
	return compressSolution(answer) == compressSolution(input);
	
func compressSolution(string):
	string = string.replace(" ", "")
	string = string.to_lower()
	return string
