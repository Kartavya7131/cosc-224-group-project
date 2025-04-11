extends Node2D

@onready var sequencer = $UI/Margins/Body/Sequencer
@onready var descLabel = $UI/Margins/Body/Description/CenterContainer/Label
@onready var TitleLabel = $UI/Margins/Body/Question/MarginContainer/Label
@onready var hintLabel = $UI/Margins/Body/BottomBar/HBoxContainer/Label

var levelId
var levelType

func LoadLevel(attacker: bool, levelId: int):
	levelType = attacker
	self.levelId = levelId
	var data = LevelsData.GetLevelData(attacker, levelId)
	
	TitleLabel.text = data[0]
	descLabel.text = data[1]
	hintLabel.text = "*Hint* : %s" % data[2]
	hintLabel.hide()
	
	var seq: Array[String]
	seq.append_array(data[3])
	var dud: Array[String]
	dud.append_array(data[4])
	
	sequencer.Init(seq, dud, hintLabel)
	
func _ready() -> void:
	LoadLevel(false, 0)
