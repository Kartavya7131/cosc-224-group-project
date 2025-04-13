extends Node

var DefenderLevels = {
	0: {
		"desc": "Someone is trying to bypass the login page using an \"OR '1'='1'\" \n statement what methodes can be used to prevent the SQL injection from happening?",
		"hint": "this is a hint",
		"seq": ["var 1", "var 2", "var3"],
		"dud": ["dud 1", "dud 2"]
		}
}

var AttackerLevels = {
	
}

func hasNextLevel(Attacker: bool, levelId: int):
	var data
	if (Attacker):
		data = AttackerLevels
	else:
		data = DefenderLevels
		
	return data.has((levelId + 1))

func GetLevelData(Attacker: bool, levelId: int):
	var title
	var data
	if (Attacker):
		data = AttackerLevels.get(levelId)
		title = "Attacker Level %d" % (levelId + 1)
	else:
		data = DefenderLevels.get(levelId)
		title = "Defender Level %d" % (levelId + 1)
		
	return [title, data.get("desc"), data.get("hint"), data.get("seq"), data.get("dud")]
	
