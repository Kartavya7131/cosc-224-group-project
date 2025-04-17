extends Button

@export var LevelId: int
@export var IsAttacker: bool

func LoadLevel():
	var scene = preload("res://scenes/DynamicLevel.tscn").instantiate()
	
	scene.levelId = self.LevelId
	scene.levelType = self.IsAttacker
	
	get_tree().root.add_child(scene)
	
func _pressed() -> void:
	LoadLevel()
