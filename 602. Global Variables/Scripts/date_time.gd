class_name DateTime extends Resource

@export_range(0,59) var seconds: int = 0
@export_range(0,59) var minutes: int = 0
@export_range(0,23) var hours: int = 8
@export_range(1,7) var days: int = 1

var formatted_time: String = ""
var delta_time: float = 0
var day_names = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]


func increase_by_sec(delta_seconds: float) -> void:
	delta_time += delta_seconds
	if delta_time < 1: return
	
	var delta_int_seconds: int = delta_time
	delta_time -= delta_int_seconds
	
	seconds += delta_int_seconds
	minutes += seconds / 60
	hours += minutes / 60
	days += hours / 24
	
	seconds = seconds % 60
	minutes = minutes % 60
	hours = hours % 24
	days = ((days - 1) % 7) + 1
	
	var formatted_hours: String
	if hours < 10:
		formatted_hours = "0" + str(hours)
	else:
		formatted_hours = str(hours)
	
	var formatted_minutes: String
	if minutes < 10:
		formatted_minutes = "0" + str(minutes)
	else:
		formatted_minutes = str(minutes)
	
	var formatted_seconds: String
	if seconds < 10:
		formatted_seconds = "0" + str(seconds)
	else:
		formatted_seconds = str(seconds)
	
	# Get the day name
	var day_name = day_names[days - 1]
	
	# Print formatted time with day name
	formatted_time = day_name + " " + formatted_hours + ":" + formatted_minutes + ":" + formatted_seconds
