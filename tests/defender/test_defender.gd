extends "res://addons/gut/test.gd"  # Ensure it extends GUT

var sql_simulator
var sql_database

func before_all():
	sql_database = preload("res://script/SqlDatabase.gd").new()
	sql_simulator = preload("res://script/sqlsimulater.gd").new()

func test_get_valid_table():
	var result = sql_database.GetTable("users")
	assert_true(result.size() > 0, "Table 'users' should return data")

func test_get_invalid_table():
	var result = sql_database.GetTable("invalid_table")
	assert_eq(result, [], "Invalid table should return empty array")

func test_decode_basic_query():
	var query = "SELECT username, age FROM users WHERE age > 30;"
	var decoded = sql_simulator.DecodeQuery(query)
	assert_eq(decoded[0], "users", "Table should be 'users'")
	assert_eq(decoded[1], ["username", "age"], "Columns should be [username, age]")
	assert_eq(decoded[2].size(), 1, "One condition should be present")

func test_select_all_columns():
	var query = "SELECT * FROM users WHERE id = 1;"
	var decoded = sql_simulator.DecodeQuery(query)
	assert_eq(decoded[1][0], "*", "All columns should be selected")

func test_condition_result():
	var row = {"username": "alice", "age": 25}
	var condition = ["age", ">", "20"]
	var result = sql_simulator.conditionResult(row, condition)
	assert_true(result, "Condition should evaluate to true")

func test_invalid_condition():
	var row = {"username": "alice", "age": 25}
	var condition = ["age", "!=", "30"]
	var result = sql_simulator.conditionResult(row, condition)
	assert_true(result, "Condition should evaluate to true")

#func test_execute_basic_query():
	#var query = "SELECT name FROM users WHERE age > 30;"
	#var result = sql_simulator.ExecuteQuery(query)
	#assert_not_null(result, "Query should return results")

func test_eval_logic_array():
	var logic_array = [true, "and", false]
	var result = sql_simulator.EvalLogicArray(logic_array)
	assert_false(result, "Logic should evaluate to false")

func test_check_solution():
	var level_checker = load("res://script/LevelChecker.gd").new()
	level_checker.answer = "SELECT * FROM users;"
	assert_true(level_checker.checkSolution("SELECT * FROM users;"), "Correct query should pass")
	assert_true(level_checker.checkSolution("select * from users;"), "Case-insensitive query should pass")
	assert_false(level_checker.checkSolution("SELECT age FROM users;"), "Incorrect query should fail")
