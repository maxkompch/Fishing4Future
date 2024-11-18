extends Node


@export var file_path = "res://logging_file.txt"
var file = null
var counter = 0

var logs = {
	"tes1": "test2"
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timestamp = Time.get_datetime_string_from_system()
	file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		print("logfile created")
		file.close()
	else:
		print("logfile not created!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func logdata(dataname:String,data:String):
	logs[str(counter)] = dataname + "," + data
	counter = counter + 1



func _on_tree_exited() -> void:
	var timestamp = Time.get_datetime_string_from_system()
	file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.seek_end()
		for loged_data in logs:
			var datavalue = logs[loged_data]
			file.store_line(file.get_as_text() + timestamp + "," + loged_data + "," + datavalue )
		print("Data logged")
		file.close()
	else:
		print("logging file cant be opened")
	
	#file.close()
	
