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
		"windesc": " SQL INJECTION BLOCKED USING DEFENSE-IN-DEPTH. INPUT WAS VALIDATED AND EXECUTED VIA SAFE DATABASE INTERFACES.\n'OR 1=1' HAD NO EFFECT ON THE QUERY EXECUTION.",
		"hasOrder": false
		},
	1: {
		"desc": "Someone is trying to bypass the login page using an \"OR '1'='1'\" statement \n\nThe Query they are giving is:\nSELECT * FROM users WHERE username = 'name' OR '1'='1'-- AND password = 'pass'; \nRewrite the query to ensure that this attack is invalid!",
		"hint": "QUOTE() function automatically avoids special characters like '.",
		"seq": ["SELECT *", "FROM users", "WHERE", "Username =", "QUOTE('Input');"],
		"dud": ["NULL", "PROCESS('Input');"],
		"windesc": "temp",
		},
	2: {
		"desc": "The following code segment is used to store a users comments and is vulnerable to SQL injection:\n\nINSERT INTO comments (text) VALUES ('\" + Hacking the database + \"');\nYour job is to fix the query to prevent malicious injection attacks.\n\n *note* : Define the method before defining variable(s)",
		"hint": "Use  a methods that prevent raw input from being executed as code.",
		"seq": ["PREPARE stmt FROM", "\'INSERT INTO comments (text) VALUES (?)\';", "SET @input = [user_input];", "EXECUTE stmt", "USING @input;"],
		"dud": ["INSERT 'user_input'", "STRING user_input", "SELECT ALL", "CONCAT(user_input)"],
		"windesc": "You’ve safely stored user comments using prepared statements. \nWell done!",
		},
	3: {
		"desc": "A system is using query to check a user's existence:\nSELECT * FROM users WHERE username = '\" + MyAccount + \"';\n\nAn attacker is using the statment:\n' OR IF(1=1, SLEEP(5), 0);--\n\n This statment causes a delay to check vulnerablility. \nYou must write a query to defend against this type of SQL injection attack.",
		"hint": "you shouldn't allow raw input in logic branches. \nPrepared statements prevent conditional injections like IF(...).",
		"seq": ["PREPARE stmt FROM", "\'SELECT * FROM users", "WHERE username = (?)\'", "SET @input = [user_input];", "EXECUTE stmt", "USING @input;"],
		"dud": ["USE CONCAT", "TRIM input", "LOG delay", "SET timeout = 0"],
		"windesc": "BY USING DATABASE ESCAPING WITH QUOTE(), YOU NEUTRALIZED MALICIOUS INPUT. SPECIAL CHARACTERS WERE HANDLED SAFELY, PREVENTING THE INJECTION.",
		}
}
var AttackerLevels = {
	0: {
		"desc": "You found a login form that checks for username and password\n The query used is: SELECT * FROM users WHERE username = 'INPUT' AND password = 'INPUT';\n You must log in without knowing the correct password! ",
		"hint": "Try creating an SQL statment that will always equate to true",
		"seq": ["OR 1=1;", "--"],
		"dud": ["1=2", "DROP TABLE users", "UPDATE users SET"],
		"windesc": "WITH A CORRECT INJECTION STATEMENT, YOU GAINED ACCESS TO THE ACCOUNT WITHOUT A PASSWORD. THE LOGIN QUERY RETURNED TRUE FOR ALL INPUTS.\nUSERNAME: Player 1\nPASSWORD: **** OR '1' = '1';"
		},
	1: {
		"desc": "You are trying to access a data base using this SQL statment\n SELECT id, username, password FROM users WHERE id = 'input'; \n How can you extract all user data? ",
		"hint": "Try using UNION SELECT for retrieving multiple query results.",
		"seq": ["UNION SELECT id,", "username,","password FROM users;"],
		"dud": ["SELECT *", "WHERE TABLE = 'users';", "UPDATE users SET"],
		"windesc": "YOU INJECTED A UNION QUERY AND RETRIEVED ALL USER RECORDS FROM THE DATABASE. FULL CREDENTIAL LEAK ACHIEVED.\nSTATEMENT: ' UNION SELECT id, username, password FROM users;"
		},
	2: {
		"desc": "You have find a system updates user passwords with:\n UPDATE users SET password = 'input' WHERE username = 'input'; \n How can you change the admin's password to hacked?",
		"hint": "Try using UNION SELECT for retrieving multiple query results.",
		"seq": ["UPDATE users", "SET password = 'hacked'","WHERE username = 'admin';"],
		"dud": ["SelectTable", "From TABLE = 'users';"],
		"windesc": " YOU SUCCESSFULLY INJECTED AN UPDATE STATEMENT TO RESET THE ADMIN PASSWORD. THE DATABASE WAS MODIFIED.\nSTATEMENT: '; UPDATE users SET password='hacked' WHERE username='admin';"
		},
	3: {
		"desc": "A system verifies user access using:\n SELECT * FROM users WHERE username = 'input'; \n  How can you check if the system is vulnerable without seeing output?",
		"hint": "Use a timing-based attack to detect vulnerabilities.",
		"seq": ["OR IF(", "1=1,","SLEEP(5),","0",");--"],
		"dud": ["ELSE IF(", "Password=1","Sleep()"],
		"windesc": "YOU DEPLOYED A TIME-BASED SQL INJECTION TO MEASURE RESPONSE DELAYS. A 5-SECOND DELAY CONFIRMS SQLI VULNERABILITY.\nPAYLOAD: ' OR IF(1=1, SLEEP(5), 0);"
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
		
	return [title, data.get("desc"), data.get("hint"), data.get("seq"), data.get("dud"), data.get("windesc"), order]
