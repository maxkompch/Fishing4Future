extends Control
var last_minute: int = -1  # Initialize with an invalid value

func _ready() -> void:
	# Initialize the display with the current time
	GameData.load_data()
	update_time_display()
	update_fish_display() 
	update_money_display()
	update_plastic_display()
	

func _process(delta: float) -> void:
	# Get the current time
	var current_time = time_system.get_time()
	var total_fish = str(GameData.total_fish_caught)
	var total_money = str(GameData.player_money)
	var total_plastic = str(GameData.total_plastic_caught)
	var target_plastic = str(GameData.plastic_target)
	update_time_display()
	update_fish_display()  
	update_money_display()
	update_plastic_display()
	
func update_time_display() -> void:
	$Resources/TimeContainer/TimeDisplay.text = time_system.get_time()
	
func update_fish_display() -> void:
	GameData.load_data()
	$Resources/FishContainer/Fish.text = str(GameData.total_fish_caught)
	
func update_money_display() -> void:
	GameData.load_data()
	$Resources/MoneyContainer/Money.text = "$" + str(GameData.player_money)
	
func update_plastic_display() -> void:
	GameData.load_data()
	$Resources/PlasticContainer/Plastic.text = str(GameData.total_plastic_caught) + "/" + str(GameData.plastic_target)
	
