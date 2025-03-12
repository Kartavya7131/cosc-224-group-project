extends "res://addons/gut/test.gd"

class_name UITest

var mainmenu = load("res://scenes/MainMenu.tscn")

func test_start_button():
	var start_menu = mainmenu.instance()
	
	add_child(start_menu)
	
	var start_button = start_menu.get_node("StartButton")
	
	assert_not_null(start_button, "Start button does not exist in scene")
	
	assert_true(start_button.is_connected("pressed", start_menu, "_on_Start_pressed"), 
		"Start button's 'pressed' signal is NOT connected to '_on_Start_pressed'")
		
	start_button.emit_signal("pressed")
	
	start_menu.queue_free()
