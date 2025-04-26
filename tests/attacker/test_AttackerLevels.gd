extends "res://addons/gut/test.gd"  # Ensure it extends GUT

# Create a test suite for attacker levels
class_name test_AttackerLevels

# Load the script managing Attacker Level 1
var attacker_level_1 = preload("res://scenes/_Old/AttackerLevel1.tscn").instantiate()

func test_attacker_level_1_bypass_login():
	var result = attacker_level_1.process_input("OR'1'='1';")
	assert_true(result, "Login bypass should be successful with SQL injection.")
	
func test_attacker_level_1_bypass_login_2():
	var result = attacker_level_1.process_input("OR'2'='2';")
	assert_true(result, "Login bypass should be successful with SQL injection.")

func test_attacker_level_1_invalid_input():
	var result = attacker_level_1.process_input("wrongpassword")
	assert_false(result, "Invalid login attempt should fail.")

func test_attacker_level_1_invalid_input1():
	var result = attacker_level_1.process_input("'or'1'='1'")
	assert_false(result, "Invalid login attempt should fail.")

# Load the script managing Attacker Level 2
var attacker_level_2 = preload("res://scenes/_Old/AttackerLevel2.tscn").instantiate()

func test_attacker_level_2_data_extraction():
	var result = attacker_level_2.process_input("'UNIONSELECTid,username,passwordFROMusers;")
	assert_true(result, "SQL injection should retrieve user data.")

func test_attacker_level_2_invalid_input():
	var result = attacker_level_2.process_input("'UNIONSELECTid,username,passwordFROMTeacher;")
	assert_false(result, "Input should not return unauthorized data.")
	
func test_attacker_level_2_invalid_input1():
	var result = attacker_level_2.process_input("union select id, user, password")
	assert_false(result, "Input should not return unauthorized data.")

# Load the script managing Attacker Level 3
var attacker_level_3 = preload("res://scenes/_Old/AttackerLevel3.tscn").instantiate()

func test_attacker_level_3_modify_data():
	var result = attacker_level_3.process_input("';UPDATEusersSETpassword='hacked'WHEREusername='admin';")
	assert_true(result, "SQL injection should modify user password.")

func test_attacker_level_3_secure_input():
	var result = attacker_level_3.process_input("usersSETpassword='hacked'WHEREusername='admin';")
	assert_false(result, "Valid input should not trigger SQL injection.")

# Load the script managing Attacker Level 4
var attacker_level_4 = preload("res://scenes/_Old/AttackerLevel4.tscn").instantiate()

func test_attacker_level_4_blind_sql_injection():
	var result = attacker_level_4.process_input("'ORIF(1=1,SLEEP(5),0);--")
	assert_true(result, "Blind SQL Injection should introduce delay.")
	
func test_attacker_level_4_blind_sql_injection_10():
	var result = attacker_level_4.process_input("'ORIF(1=1,SLEEP(10),0);--")
	assert_true(result, "Blind SQL Injection should introduce delay.")

func test_attacker_level_4_invalid_attempt():
	var result = attacker_level_4.process_input("'ORIF(1=1,SLEEP(),0);--")
	assert_false(result, "Normal input should not trigger SQL injection.")
	
