extends Node

func SelectFromColumns(data, columns):
	var function_result = []
	
	for row in data:
		var selected_row = {}
		if columns[0] == "*":
			function_result.append(row)
		else:
			for column in columns:
				if row.has(column):
					selected_row[column] = row[column]
			function_result.append(selected_row)
		
	return function_result
	
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
	var querydata = DecodeQuery(query)
	var table = SqlDatabase.GetTable(querydata[0])
	
	var columns = SelectFromColumns(table, querydata[1])
	
	print("Table: ", querydata[0], "; Columns: ", querydata[1], "; Where: ", querydata[2], " -> ")
	print(columns)
	
func DecodeQuery(query: String):
	query = query.replace(",", "").replace(";", "").to_lower()
	var keywords = query.replace(",", "").split(" ")
	keywords.append(";")
	
	var mode = ""
	var count = 0
	
	var colIds = []
	var table = ""
	var conditions = []
	
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
	return [table, colIds, conditions]
	
func conditionResult(dataRow, conditionQuery):
	var key = conditionQuery[0]
	var opperator = conditionQuery[1]
	return 0
	
@onready var input_field = $InputField
func _on_level_check_button_down() -> void:
	ExecuteQuery(input_field.text)
