extends "res://addons/gut/test.gd"

class_name UITest

var start_menu  # Store reference to MainMenu instance

func set_up():
	var mainmenu = load("res://scenes/MainMenu.tscn")
	assert_not_null(mainmenu, "MainMenu scene failed to load")

	start_menu = mainmenu.instantiate()
	assert_not_null(start_menu, "MainMenu instance failed to create")

	add_child(start_menu)  # Add to scene tree so `get_tree()` works
	await get_tree().process_frame  # Wait for nodes to initialize

func test_start_button():
	var start_button = start_menu.get_node("VBoxContainer/StartButton")
	assert_not_null(start_button, "Start button does not exist in VBoxContainer")

	assert_true(start_button.is_connected("pressed", Callable(start_menu, "_on_Start_pressed")), 
		"Start button's 'pressed' signal is NOT connected to '_on_Start_pressed'")

	start_button.emit_signal("pressed")
