extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_goBack_pressed():
	get_tree().change_scene_to_file("res://scenes/GameScene1.tscn")


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerLevel1_Modified.tscn")
func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerLevel2.tscn")
func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerLevel3.tscn")
func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerLevel4.tscn")
func _on_level_5_pressed():
	get_tree().change_scene_to_file("res://scenes/AttackerLevel1_Modified.tscn")
