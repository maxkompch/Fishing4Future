extends Control
var last_minute: int = -1  # Initialize with an invalid value

func _ready() -> void:
	# Initialize the display with the current time
	update_time_display()

func _process(delta: float) -> void:
	# Get the current time
	var current_time = time_system.get_time()
	update_time_display()  # Assume this returns a string representation of the time

func update_time_display() -> void:
	$TimeShow.text = time_system.get_time()
