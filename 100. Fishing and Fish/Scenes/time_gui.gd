extends Control
var last_minute: int = -1  # Initialize with an invalid value

func _ready() -> void:
	# Initialize the display with the current time
	GameData.load_data()
	update_time_display()
	update_fish_display() 
	

func _process(delta: float) -> void:
	# Get the current time
	var current_time = time_system.get_time()
	var total_fish = str(GameData.total_fish_caught)
	update_time_display()
	update_fish_display()  
	
func update_time_display() -> void:
	$TimeShow.text = time_system.get_time()
	
func update_fish_display() -> void:
	GameData.load_data()
	$FishBar.text = str(GameData.total_fish_caught)
