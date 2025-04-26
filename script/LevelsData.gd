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
		"windesc": " SQL INJECTION BLOCKED USING DEFENSE-IN-DEPTH.\nINPUT WAS VALIDATED AND EXECUTED VIA SAFE DATABASE INTERFACES.\n'OR 1=1' HAD NO EFFECT ON THE QUERY EXECUTION.",
		"codexEntry": ["Avoid building queries by directly attaching user input. Instead, look into methods that separate logic from values — these techniques stop injected logic from being interpreted."],
		"hasOrder": false
		},
	1: {
		"desc": "Someone is trying to bypass the login page using an \"OR '1'='1'\" statement \n\nThe Query they are giving is:\nSELECT * FROM users WHERE username = 'name' OR '1'='1'-- AND password = 'pass'; \nHow can you modify the query construction to neutralize this risk?",
		"hint": "QUOTE() function automatically avoids special characters like '.",
		"seq": ["SELECT *", "FROM users", "WHERE", "Username =", "QUOTE('Input');"],
		"dud": ["NULL", "PROCESS('Input');"],
		"windesc": "BY USING DATABASE ESCAPING WITH QUOTE(), \nYOU NEUTRALIZED MALICIOUS INPUT. \nSPECIAL CHARACTERS WERE HANDLED SAFELY, PREVENTING THE INJECTION.",
		"codexEntry": ["Special characters in strings can break query structure. Consider functions that neutralize input by wrapping or escaping it safely."]
		},
	2: {
		"desc": "The following code segment is used to store a users comments and is vulnerable to SQL injection:\n\nINSERT INTO comments (text) VALUES ('\" + Hacking the database + \"');\nYour job is to fix the query to prevent malicious injection attacks.\n\n *note* : Define the method before defining variable(s)",
		"hint": "Use  a methods that prevent raw input from being executed as code.",
		"seq": ["PREPARE stmt FROM", "\'INSERT INTO comments (text) VALUES (?)\';", "SET @input = [user_input];", "EXECUTE stmt", "USING @input;"],
		"dud": ["INSERT 'user_input'", "STRING user_input", "SELECT ALL", "CONCAT(user_input)"],
		"windesc": "YOU'VE SAFELY STORED USER COMMENTS USING PREPARED STATEMENTS. \nWELL DONE",
		"codexEntry": ["When handling text input, think about whether the input is ever executed as code. Using the right database feature can force the system to treat it as plain data only."]
		},
	3: {
		"desc": "A system is using query to check a user's existence:\nSELECT * FROM users WHERE username = '\" + MyAccount + \"';\n\nAn attacker is using the statment:\n' OR IF(1=1, SLEEP(5), 0);--\n\n This statment causes a delay to check vulnerablility. \nYou must write a query to defend against this type of SQL injection attack.",
		"hint": "you shouldn't allow raw input in logic branches. \nPrepared statements prevent conditional injections like IF(...).",
		"seq": ["PREPARE stmt FROM", "\'SELECT * FROM users", "WHERE username = (?)\'", "SET @input = [user_input];", "EXECUTE stmt", "USING @input;"],
		"dud": ["USE CONCAT", "TRIM input", "LOG delay", "SET timeout = 0"],
		"windesc": "BY USING DATABASE ESCAPING WITH QUOTE(),\n YOU NEUTRALIZED MALICIOUS INPUT.\n SPECIAL CHARACTERS WERE HANDLED SAFELY, PREVENTING THE INJECTION.",
		"codexEntry": ["Time-based probes rely on control flow logic. To block these, ensure user inputs can't affect conditionals — enforce strict structure in query execution."]
		}
}
var AttackerLevels = {
	0: {
		"desc": "You found a login form that checks for username and password\n The query used is:\n SELECT * FROM users WHERE username = 'INPUT' AND password = 'INPUT';\n You must log in without knowing the correct password! ",
		"hint": "Try creating an SQL statment that will always equate to true",
		"seq": ["OR","'1'='1';", "--"],
		"dud": ["'1'='2';", "DROP TABLE users", "UPDATE users SET"],
		"windesc": "WITH A CORRECT INJECTION STATEMENT,\n YOU GAINED ACCESS TO THE ACCOUNT WITHOUT A PASSWORD.\n THE LOGIN QUERY RETURNED TRUE FOR ALL INPUTS.\nUSERNAME: Player 1\nPASSWORD: **** OR '1' = '1';",
		"codexEntry": ["Think about how logical operators in SQL behave. If any part of a WHERE clause is true, the whole thing can pass. Can you craft a condition that always returns true, regardless of the input?"]
		},
	1: {
		"desc": "You are trying to access a data base using this SQL statment\n SELECT id, username, password FROM users WHERE id = 'input'; \n How can you extract all user data? ",
		"hint": "Try using UNION SELECT for retrieving multiple query results.",
		"seq": ["UNION SELECT id,", "username,","password FROM users;--"],
		"dud": ["SELECT *", "WHERE TABLE = 'users'--;", "UPDATE users SET"],
		"windesc": "YOU INJECTED A UNION QUERY AND \nRETRIEVED ALL USER RECORDS FROM THE DATABASE.\nFULL CREDENTIAL LEAK ACHIEVED.",
		"codexEntry": ["SQL can combine results from multiple queries using a special keyword. Explore whether your injection can extend the original result set with your own data — but make sure your columns align."]
		},
	2: {
		"desc": "You have discovered a vulnerable system that allows you to modify\n user data through input fields.\n How could you manipulate the system to reset the admin's password without authorization?",
		"hint": "Consider how ending a query early could let you inject a new SQL command,\n Try injecting an UPDATE statement",
		"seq": ["UPDATE users", "SET password = 'hacked'", "WHERE username = 'admin';--"],
		"dud": ["SelectTable", "From TABLE = 'users';--"],
		"windesc": "YOU SUCCESSFULLY INJECTED\nAN UPDATE STATEMENT TO RESET THE ADMIN PASSWORD.\nTHE DATABASE WAS MODIFIED.",
		"codexEntry": ["Some systems don't stop you after one SQL statement. Try closing the current query cleanly and then think about how to introduce a second, malicious one."]
},
	3: {
		"desc": "A system verifies user access using:\n SELECT * FROM users WHERE username = 'input'; \n  How can you check if the system is vulnerable without seeing output?",
		"hint": "Use a timing-based attack to detect vulnerabilities.",
		"seq": ["OR IF(", "'1'='1',","SLEEP(5),","'0'",");--"],
		"dud": ["ELSE IF(", "Password=1","Sleep()"],
		"windesc": "YOU DEPLOYED A TIME-BASED SQL INJECTION TO MEASURE RESPONSE DELAYS. \nA 5-SECOND DELAY CONFIRMS SQLI VULNERABILITY.\nPAYLOAD: ' OR IF(1=1, SLEEP(5), 0);",
		"codexEntry": ["If you can't see data, can you still detect behavior? Look into ways SQL can delay responses — time itself can be used as a signal."]
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
		
	return [title, data.get("desc"), data.get("hint"), data.get("seq"), data.get("dud"), data.get("windesc"), order, data.get("codexEntry")]
