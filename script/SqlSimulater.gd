extends Node

var AllTables = []

func _ready() -> void:
	AllTables.append(users)

#          Id                 Username                  Password                        Name                Age
var users = [
	{"id": 1,   "username": "wild_fox_25",      "password": "X7g!mB2#h",   "name": "Alice Williams",   "age": 25},
	{"id": 2,   "username": "urban_explorer89", "password": "R3d8L#1y",    "name": "Bob Smith",        "age": 30},
	{"id": 3,   "username": "charliebeatz",     "password": "Q2!zXg#e",    "name": "Charlie Jones",    "age": 35},
	{"id": 4,   "username": "david_in_motion",  "password": "A8p*V1s",     "name": "David Miller",     "age": 40},
	{"id": 5,   "username": "eve_runner22",     "password": "V4z*3Yd",     "name": "Eve Brown",        "age": 22},
	{"id": 6,   "username": "frankie_2cool",    "password": "T5r#K9m2",    "name": "Frank Lee",        "age": 28},
	{"id": 7,   "username": "grace.horizon",    "password": "F9#X1p3D",    "name": "Grace Davis",      "age": 26},
	{"id": 8,   "username": "hannah_jetset",    "password": "S7@Qm8D",     "name": "Hannah Martin",    "age": 31},
	{"id": 9,   "username": "ian_ontheroad",    "password": "Y6tP!z1D",    "name": "Ian Clark",        "age": 29},
	{"id": 10,  "username": "jake_waves",       "password": "L4e#5W9m",    "name": "Jake Fox",         "age": 32},
	{"id": 11,  "username": "kelly_metro",      "password": "K3#W8f1",     "name": "Kelly Wilson",     "age": 24},
	{"id": 12,  "username": "lucas_dreamer",    "password": "J6h!K0q",     "name": "Lucas Garcia",     "age": 33},
	{"id": 13,  "username": "mona_stealth",     "password": "R3#N9bQ",     "name": "Mona Perez",       "age": 27},
	{"id": 14,  "username": "nina_vibes",       "password": "B5w!D7p",     "name": "Nina Taylor",      "age": 34},
	{"id": 15,  "username": "oliver_glitch",    "password": "J2rX!9V",     "name": "Oliver Lee",       "age": 38},
	{"id": 16,  "username": "peter_sparks",     "password": "D4q@S2Y",     "name": "Peter Johnson",    "age": 26},
	{"id": 17,  "username": "quinn_breeze",     "password": "M3x9Jr2#",    "name": "Quinn Moore",      "age": 39},
	{"id": 18,  "username": "rachel_wanderer",  "password": "T6kP!f2N",    "name": "Rachel Evans",     "age": 23},
	{"id": 19,  "username": "sam_travel",       "password": "F7#W9q0L",    "name": "Sam Roberts",      "age": 28},
	{"id": 20,  "username": "tina_zenith",      "password": "P2mR@Z6D",    "name": "Tina Walker",      "age": 32}
]


func SelectFromColumn(data, column):
	var results = []
	for row in data:
		if (row.has(column)):
			results.append(row)
	return results
	
func SelectFromColumns(data, columns):
	var functionResult = []
	for column in columns:
		var results = []
		for row in data:
			if (row.has(column)):
				results.append(row)
		functionResult.append(results)
	return functionResult
	
func WhereBool(data, funct):
	var function = Callable(self, funct)
	
	var result = []
	for row in data:
		if function.call(row):
			result.append(row)
	return result
	
func WhereData(data, funct, expected):
	var function = Callable(self, funct)
	
	var result = []
	for row in data:
		if function.call(row) == expected:
			result.append(row)
	return result
	
func OrderData(data, column, ascending=true):
	return data.sort_custom(self, "ColumnSort", ascending, column)

func ColumnSort(a, b, column):
	if a[column] < b[column]:
		return -1
	elif a[column] > b[column]:
		return 1
	return 0
	
func ExecuteQuery(query: String):
	query = query.replace(",", "").replace(";", "").to_lower()
	var keywords = query.replace(",", "").split(" ")
	
	keywords.append(";")
	
	print(keywords)
	
	var mode = ""
	var count = 0
	
	var colIds = []
	var table = ""
	var conditions = []
	
	# Select age, name from users WHERE age >= 32
	
	if (keywords[0] == "select"):
		var args = []
		for key in keywords:
			if key == ";":
				break
			
			match key:
				"select":
					mode = "sel"
					count += 1
					continue
				"from":
					mode = "frm"
					count += 1
					continue
				"where":
					mode = "whr"
					count += 1
					continue
				"and", "or":
					count += 1
					conditions.append(key)
					continue
					
					
			if mode == "sel":
				args.append(key)
				if keywords[count+1] == "from":
					colIds.append_array(args)
					args.clear()
					
			if mode == "frm":
				table = key
				
			if mode == "whr":
				args.append(key)
				if keywords[count+1] == "and" || keywords[count+1] == "or" || keywords[count+1] == ";":
					conditions.append(args.duplicate())
					args.clear()
					
			count += 1
			
	print("Columns: ", colIds)
	print("Table: ", table)
	print("Conditions: ", conditions)
	
@onready var input_field = $InputField
func _on_level_check_button_down() -> void:
	ExecuteQuery(input_field.text)
