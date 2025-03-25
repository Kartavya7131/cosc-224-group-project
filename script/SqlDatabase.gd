extends Node

var database = {
	"users": [
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
}

func GetTable(table_name : String):
	if (database.has(table_name)):
		return database[table_name];
	else:
		print(table_name, " is not a valid table")
		return []
