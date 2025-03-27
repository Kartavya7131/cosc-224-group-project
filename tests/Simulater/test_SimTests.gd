extends "res://addons/gut/test.gd"

var simulator;
func before_all():
	simulator = preload("res://script/SqlSimulater.gd").new();
	
func test_LogicTest():
	var logic = [true, "and", false];
	var output = simulator.EvalLogicArray(logic);
	assert_false(output, "Logic result is valid");
	
func test_ConditionTest():
	var row = SqlDatabase.GetTable("users")[0];
	var where = ["age", ">", "19"];
	
	var output = simulator.conditionResult(row, where);
	
	assert_true(output, "This user is over 19");
	
func test_DecodeTest():
	var query = "SELECT * FROM users WHERE id = 1;";
	var decoded = simulator.DecodeQuery(query);
	assert_eq(decoded[0], "users", "User table is Selected");
	assert_eq(decoded[1][0], "*", "All columns should be selected");

func test_ExecuteTest():
	var query = "Select name, age From users Where age >= 30 and name like 'Hannah'";
	
	var result = simulator.ExecuteQuery(query);
	
	var row = result[0];
	
	assert_eq(row["name"], "Hannah Martin", "User id is correct");
	assert_eq(row["age"], 31, "User age is correct");
	
func test_SelectTest():
	var columns = ["id", "age"];
	var table = SqlDatabase.GetTable("users");
	
	var selected = simulator.SelectFromColumns(table, columns);
	var row = selected[0];
	
	assert_eq(row["id"], 1, "User id is correct");
	assert_eq(row["age"], 25, "User age is correct");
	assert_false(row.has("name"), "User name is not selected");
