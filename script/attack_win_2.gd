extends Control

func _on_next_level_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerLevel3.tscn")

func _on_Level_Select_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")
