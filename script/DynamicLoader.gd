extends Node2D

@onready var sequencer = $UI/Margins/Body/Sequencer
@onready var winpopup = $UI/Margins/WinPopup

@onready var descLabel = $UI/Margins/Body/Description/CenterContainer/Label
@onready var TitleLabel = $UI/Margins/Body/Question/MarginContainer/Label
@onready var hintLabel = $UI/Margins/Body/BottomBar/HBoxContainer2/HBoxContainer/Label
@onready var attemptLabel = $UI/Margins/Body/BottomBar/HBoxContainer2/MarginContainer/Label2

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
	
func _ready() -> void:
	LoadLevel()

func GoBack_pressed() -> void:
	if levelType:
		get_tree().change_scene_to_file("res://scenes/AttackerPage.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/DefenderPage.tscn")
