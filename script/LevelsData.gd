extends Node

#desc is the level description
#hint will appear when attempts = 5
#seq is the answer to the level
#dud is the other incorrect buttons

var DefenderLevels = {
	0: {
		"desc": "Someone is trying to bypass the login page using an \"OR '1'='1'\" \n statement what methodes can be used to prevent the SQL injection from happening?",
		"hint": "Avoid relying on tricks like string concat or client-side checks.",
		"seq": ["Use Prepared Statement","Input Validation","ORM Framework", "Least Privilege"],
		"dud": ["Use String Concatenation","Disable Errors", "Trust Admin Input", "Client-side Checks Only"],
		"hasOrder": false
		},
	1: {
		"desc": "Someone is trying to bypass the login page using an \"OR '1'='1'\" statement \n\nThe Query they are giving is:\nSELECT * FROM users WHERE username = 'name' OR '1'='1'-- AND password = 'pass'; \nRewrite the query to ensure that this attack is invalid!",
		"hint": "QUOTE() function automatically avoids special characters like '.",
		"seq": ["SELECT *", "FROM users", "WHERE", "Username =", "QUOTE('Input');"],
		"dud": ["NULL", "PROCESS('Input');"],
		}
		
}

var AttackerLevels = {
	0: {
		"desc": "You found a login form that checks for username and password\n The query used is: SELECT * FROM users WHERE username = 'INPUT' AND password = 'INPUT';\n You must log in without knowing the correct password! ",
		"hint": "Try creating an SQL statment that will always equate to true",
		"seq": ["OR 1=1;", "--"],
		"dud": ["1=2", "DROP TABLE users", "UPDATE users SET"]
		},
	1: {
		"desc": "You are trying to access a data base using this SQL statment\n SELECT id, username, password FROM users WHERE id = 'input'; \n How can you extract all user data? ",
		"hint": "Try using UNION SELECT for retrieving multiple query results.",
		"seq": ["UNION SELECT id,", "username,","password FROM users;"],
		"dud": ["SELECT *", "WHERE TABLE = 'users';", "UPDATE users SET"]
		},
	2: {
		"desc": "You have find a system updates user passwords with:\n UPDATE users SET password = 'input' WHERE username = 'input'; \n How can you change the admin's password to hacked?",
		"hint": "Try using UNION SELECT for retrieving multiple query results.",
		"seq": ["UPDATE users", "SET password = 'hacked'","WHERE username = 'admin';"],
		"dud": ["SelectTable", "From TABLE = 'users';"]
		},
	3: {
		"desc": "A system verifies user access using:\n SELECT * FROM users WHERE username = 'input'; \n  How can you check if the system is vulnerable without seeing output?",
		"hint": "Use a timing-based attack to detect vulnerabilities.",
		"seq": ["OR IF(", "1=1,","SLEEP(5),","0",");--"],
		"dud": ["ELSE IF(", "Password=1","Sleep()"]
		}
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
	
	var order:bool = true
	if data.has("hasOrder"):
		order = data.get("hasOrder")
		
	return [title, data.get("desc"), data.get("hint"), data.get("seq"), data.get("dud"), order]
	
