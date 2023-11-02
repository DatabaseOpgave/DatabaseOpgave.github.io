extends Node2D

var database := PostgreSQLClient.new()
onready var show_data = $ShowData

const USER = "vbrtcyah"
const PASSWORD = "KQ136_snVN9PUstD8-Q5XtrwukhOS2E0"
const HOST = "cornelius.db.elephantsql.com"
const PORT = 5432 
const DATABASE = "vbrtcyah"

enum sql_types {
	INSERT,
	SELECT,
	SELECTUSER,
	UPDATE,
	DELETE,	
}

var sql_type = -1


func connectDB():
	var _error := database.connect("connection_established", self, "_execAll")
	_error = database.connect("authentication_error", self, "_authentication_error")
	_error = database.connect("connection_closed", self, "_close")	
	#Connection to the database
	_error = database.connect_to_host("postgresql://%s:%s@%s:%d/%s" % [USER, PASSWORD, HOST, PORT, DATABASE])


func _authentication_error(error_object: Dictionary) -> void:
	prints("Error connection to database:", error_object["message"])
	
func _close(clean_closure := true) -> void:
	prints("DB CLOSE,", "Clean closure:", clean_closure)
	
func _physics_process(_delta: float) -> void:
	database.poll()

func _exit_tree() -> void:
	database.close()

#Call database function
func _execAll():
	
	match sql_type:
		sql_types.INSERT:
			_execInsert()
		sql_types.SELECT:
			_execSelect()
		sql_types.SELECTUSER:
			_execSelectUser()
		sql_types.UPDATE:
			_execUpdate()
		sql_types.DELETE:
			_execDelete()
			

#Insert, Select, Update & Delete : setup data & SQL
func _execInsert():
	var data = [[str($Username.get_text()), $Password.get_text()]]
	print(data)
	insertToDB('BEGIN; INSERT INTO "Login" ("Username", "Password") VALUES'+" ('%s','%s'); COMMIT;", data)

func _execSelectUser():
	var data = [str($Username.get_text()), $Password.get_text()]
	print(data)
	#print(selectFromDB('SELECT * FROM "Login"; '))
	print(selectUserFromDB('SELECT * FROM "Login" WHERE "Username" =' + "'%s' AND " + ' "Password" =' + " '%s';", data))
	
func _execSelect():
	

	var data = selectFromDB('SELECT * FROM "Login"; ')
	var return_data = ""
	
	for d in data:
		for n in d.size():
			return_data += str(d[n]) + "\t"
			print(d[n])
		return_data += "\n"
		
func _execUpdate():
	var data = [[str($Username.get_text()), $Password.get_text(), $User_id.get_text()]]
	updateToDB("BEGIN; UPDATE Login SET Username = '%s', Password = %s WHERE User_id = %s; COMMIT;", data)

func _execDelete():
	var data = [[$User_id.get_text()]]
	deleteFromDB("BEGIN; DELETE FROM Login WHERE User_id = '%s'; COMMIT;", data)


#Insert, Select, Update & Delete executes
func insertToDB(sql: String, data: Array):
	var _sql
	
	for d in data:
		_sql = sql % d
		database.execute(_sql)
		print(_sql)

	database.close()

func selectFromDB(sql:String) -> Array:
	
	var datas := database.execute(sql)
	var rows = datas[0].data_row
	
	database.close()
	
	return rows
	
func selectUserFromDB(sql:String, data: Array) -> Array:
	
	#print(sql)
	var _sql = sql % data
	print(_sql)

	var datas := database.execute(_sql)
	var rows = datas[0].data_row
	#var rows = 1
	database.close()	
	return rows
	
	
func updateToDB(sql: String, data: Array):
	var _sql
	
	for d in data:
		_sql = sql % d
		database.execute(_sql)
		print(_sql)

	database.close()

func deleteFromDB(sql: String, data: Array):
	#var datas
	var _sql
	
	for d in data:
		_sql = sql % d
		database.execute(_sql)
		print(_sql)

	database.close()


func _on_Login_create_pressed():
	sql_type = sql_types.INSERT
	connectDB()


func _on_Login_pressed():
	sql_type = sql_types.SELECTUSER
	connectDB()
	GlobalScript.User_text = str($Username.get_text())
	get_tree().change_scene("res://Scenes/mainMenu.tscn")
