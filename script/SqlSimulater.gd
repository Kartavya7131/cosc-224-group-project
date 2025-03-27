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
	
func ExecuteQuery(query: String):
	var querydata = DecodeQuery(query)
	var table = SqlDatabase.GetTable(querydata[0])
	
	var whereTable = []
	for row in table:
		var whereCheck = querydata[2].duplicate()
		
		for i in range(0, whereCheck.size(), 2):
			whereCheck[i] = conditionResult(row, whereCheck[i])
			
		if (EvalLogicArray(whereCheck)):
			whereTable.append(row)
	
	var columns = SelectFromColumns(whereTable, querydata[1])
	
	print("Table: ", querydata[0], "; Columns: ", querydata[1], "; Where: ", querydata[2], " -> ")
	print(columns)
	print("total rows: ", columns.size())
	
	return columns
	
func CountRows(data):
	return data.size()
	
func DecodeQuery(query: String):
	query = query.replace(",", "").replace(";", "").replace("\"", "").replace("\'", "").to_lower()
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
	var operator = conditionQuery[1]
	var value = conditionQuery[2];
	
	if value.is_valid_float():
		value = float(value)
	elif value.is_valid_int():
		value = int(value)
		
	var dataValue = dataRow[key];
	
	if operator == "like":
		return value in dataValue.to_lower()  # Case-insensitive match
		
	var expr = Expression.new()
	var condition_string = "x %s y" % operator
	
	if expr.parse(condition_string, ["x", "y"]) == OK:
		var result = expr.execute([dataValue, value], self)
		return result
		
	return 'Err'
	
func EvalLogicArray(logic):
	var logicStr = ""
	
	for val in logic:
		if typeof(val) == TYPE_BOOL:
			logicStr += "true" if val else "false"
		else:
			logicStr += " %s " % val
			
	var expr = Expression.new()
	if expr.parse(logicStr) == OK:
		return expr.execute()
		
	return 'Err'
