extends "res://addons/gut/test.gd"

class_name UITest

var mainmenu = preload("res://scenes/MainMenu.tscn")
var start_menu  # Store MainMenu instance

func set_up():
	print("🔵 Running set_up()...")

	# Load & instantiate MainMenu
	start_menu = mainmenu.instantiate()
	if start_menu == null:
		push_error("❌ Failed to instantiate MainMenu!")
		return

	# Add to scene tree
	add_child(start_menu)

	# Wait for scene to initialize
	await get_tree().idle_frame

	# Check if start_menu is in the scene tree
	if !start_menu.is_inside_tree():
		push_error("❌ start_menu was not added to the scene tree!")
		return

	print("✅ MainMenu added to the scene tree!")

func test_start_button():
	print("🔵 Running test_start_button...")

	# Ensure set_up() worked and start_menu is valid
	assert_not_null(start_menu, "❌ start_menu is NULL before test!")

	# Ensure StartButton exists
	var start_button = start_menu.get_node("VBoxContainer/StartButton")
	assert_not_null(start_button, "❌ StartButton does not exist!")

	# Check if the button is connected
	if !start_button.is_connected("pressed", Callable(start_menu, "_on_Start_pressed")):
		push_error("❌ StartButton signal is NOT connected!")
		return

	print("✅ StartButton is connected!")

	# Simulate button press
	start_button.emit_signal("pressed")
	print("✅ StartButton pressed successfully!")
