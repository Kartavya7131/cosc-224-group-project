extends Node2D

@onready var sequencer = $UI/Margins/Body/Sequencer
@onready var winpopup = $UI/Margins/WinPopup

@onready var descLabel = $UI/Margins/Body/Description/CenterContainer/Label
@onready var TitleLabel = $UI/Margins/Body/Question/MarginContainer/Label
@onready var hintLabel = $UI/Margins/Body/BottomBar/VBoxContainer/HBoxContainer2/MarginContainer2/Label
@onready var attemptLabel = $UI/Margins/Body/BottomBar/VBoxContainer/HBoxContainer2/MarginContainer/Label2

@onready var bookScene = preload("res://scenes/interactive_book_2d.tscn").instantiate()
@onready var bookPopup = $UI/Margins/BookPopup
@onready var bookControl = $UI/Margins/BookPopup/BookContainer
@onready var BookShown = false

@export var levelId: int
@export var levelType: bool

func LoadLevel():
	var data = LevelsData.GetLevelData(levelType, levelId)
	
	TitleLabel.text = data[0]
	descLabel.text = data[1]
	hintLabel.text = "*Hint* : %s" % data[2]
	hintLabel.hide()
	
	var seq: Array[String]
	seq.append_array(data[3])
	var dud: Array[String]
	dud.append_array(data[4])
	
	var order:bool = data[6]
	
	winpopup.Init(levelType, levelId, data[5])
	sequencer.Init(seq, dud, hintLabel, attemptLabel, order, winpopup)
	
	bookScene.init_page(data[0], data[1], data[7])
	bookPopup.visible = false
	
func _ready() -> void:
	LoadLevel()

func GoBack_pressed() -> void:
	if levelType:
		get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/DefenderPage.tscn")

func _on_codex_button_button_up() -> void:
	var data = LevelsData.GetLevelData(levelType, levelId)
	if BookShown:
		for child in bookControl.get_children():
			child.queue_free()
	else:
		var newBookScene = preload("res://scenes/interactive_book_2d.tscn").instantiate()
		newBookScene.init_page(data[0], data[1], data[7])
		bookControl.add_child(newBookScene)
	
	BookShown = !BookShown
	bookPopup.visible = BookShown
