extends Node

@onready var label = $ColorRect/MarginContainer/VBoxContainer/Body/PanelContainer/Label
@onready var menu = $ColorRect/MarginContainer/VBoxContainer/Buttons/HBoxContainer/MarginMenu/Menu
@onready var next = $ColorRect/MarginContainer/VBoxContainer/Buttons/HBoxContainer/MarginNext/Next

var levelType
var levelId

func Init(LevelType, LevelId, Desc):
	label.text = Desc
	self.levelType = LevelType
	self.levelId = LevelId
	
	if (!LevelsData.hasNextLevel(levelType, levelId)):
		next.visible = false
	
func _ready() -> void:
	self.visible = false
	
func show():
	self.visible = true
	
func hide():
	self.visible = false
	
func LoadNextLevel():
	var scene = preload("res://scenes/DynamicLevel.tscn").instantiate()
	
	scene.levelId = levelId + 1
	scene.levelType = levelType
	
	get_tree().root.add_child(scene)
	hide()

func _on_menu_button_down() -> void:
	hide()
	
	if levelType:
		get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/DefenderPage.tscn")
