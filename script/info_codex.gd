extends Node2D


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _on_back_2_pressed():
	get_tree().change_scene_to_file("res://scenes/GameScene1.tscn")
