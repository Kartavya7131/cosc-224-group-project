extends MarginContainer

var rng = RandomNumberGenerator.new()
@onready var Cloud1 = $Clouds1
@onready var Cloud2 = $Clouds2
@onready var Cloud3 = $Clouds3
@onready var Cloud4 = $Clouds4



func CloudGen():
	var rand = rng.randi_range(1,4)
	match rand:
		1: 
			Cloud1.visible = true
		2:
			Cloud2.visible = true
		3:
			Cloud3.visible = true
		4:
			Cloud4.visible = true

func _ready() -> void:
	Cloud1.visible = false
	Cloud3.visible = false
	Cloud2.visible = false
	Cloud4.visible = false
	
	CloudGen()
