class_name TimeSystem extends Node

@export var date_time: DateTime
@export var ticks_per_second: int = 240

func _ready():
	date_time = DateTime.new()  # Initialize DateTime here

func _process(delta: float) -> void:
	date_time.increase_by_sec(delta * ticks_per_second)
	
func print_time() -> void:
	if date_time:
		print(date_time.formatted_time)
	
func get_time() -> String:
	if date_time:
		return date_time.formatted_time
	return "Time not initialized"
