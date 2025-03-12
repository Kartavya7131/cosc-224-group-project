extends "res://addons/gut/test.gd"  # Ensure it extends GUT

# Create a test suite for attacker levels
class_name AttackerLevels

# Load the script managing Attacker Level 1
var attacker_level_1 = preload("res://scenes/AttackerLevel1.tscn").instantiate()

func test_attacker_level_1_bypass_login():
	var result = attacker_level_1.process_input("OR'1'='1';")
	assert_true(result, "Login bypass should be successful with SQL injection.")

func test_attacker_level_1_invalid_input():
	var result = attacker_level_1.process_input("wrongpassword")
	assert_false(result, "Invalid login attempt should fail.")

# Load the script managing Attacker Level 2
var attacker_level_2 = preload("res://scenes/AttackerLevel2.tscn").instantiate()

func test_attacker_level_2_data_extraction():
	var result = attacker_level_2.process_input("'UNIONSELECTid,username,passwordFROMusers;")
	assert_true(result, "SQL injection should retrieve user data.")

func test_attacker_level_2_invalid_input():
	var result = attacker_level_2.process_input("123")
	assert_false(result, "Input should not return unauthorized data.")

# Load the script managing Attacker Level 3
var attacker_level_3 = preload("res://scenes/AttackerLevel3.tscn").instantiate()

func test_attacker_level_3_modify_data():
	var result = attacker_level_3.process_input("';UPDATEusersSETpassword='hacked'WHEREusername='admin';")
	assert_true(result, "SQL injection should modify user password.")

func test_attacker_level_3_secure_input():
	var result = attacker_level_3.process_input("securepassword")
	assert_false(result, "Valid input should not trigger SQL injection.")

# Load the script managing Attacker Level 4
var attacker_level_4 = preload("res://scenes/AttackerLevel4.tscn").instantiate()

func test_attacker_level_4_blind_sql_injection():
	var result = attacker_level_4.process_input("'ORIF(1=1,SLEEP(5),0);--")
	assert_true(result, "Blind SQL Injection should introduce delay.")

func test_attacker_level_4_invalid_attempt():
	var result = attacker_level_4.process_input("admin")
	assert_false(result, "Normal input should not trigger SQL injection.")
