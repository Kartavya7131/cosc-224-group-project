extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_Start_pressed():
	get_tree().change_scene_to_file("res://GameScene1.tscn")


func _on_info_button_pressed():
	print("Info print")


func _on_exit_button_pressed():
	get_tree().quit()
