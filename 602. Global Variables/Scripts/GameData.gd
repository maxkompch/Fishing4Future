extends Node

# Strictly do not touch the above lines unless you are working with tutorials
var wrongFishing_shown = false
var fishingGenerally_shown = false
var time_variable_use: int = 0
# Strictly do not touch the above lines unless you are working with tutorials

const SAVE_PATH = "user://save_data.cfg"
var player_money: float = 100.0
var plastic_population: int = 5
var plastic_target: int = 21
var plastic_growth_rate: int = 3
var fish_population: int = 10
var fish_growth_rate: float = 1.5
var fish_price: float = 20
var fish_health: float = 1

var fish_caught: int = 0
var failed_fish: int = 0

var total_fish_caught: int = 0
var total_failed_fish: int = 0

var max_fish: int = 3
var max_fail: int = 3

var max_plastic: int = 3
var max_plastic_fail: int = 3

var plastic_caught: int = 0
var failed_plastic: int = 0

var total_plastic_caught: int = 0
var total_failed_plastic: int = 0

var current_time_str: String = "Monday 00:00:00"
var current_day_str : String = "Monday"
var current_day_int : int = 0 #0,1,2,3,4,5,6
var days_of_the_week = ["Monday","Tuesday","Wednesday", "Thursday","Friday", "Saturday","Sunday"]

#minigameUpgrades
#rod upgrade values should be 1,2,3,4
var fish_bubbles_amount : int = 1
var plastic_bubbles_amount : int = 1
var fish_bubbles_2 = false
var fish_bubbles_3 = false
var plastic_bubbles_2 = false
var plastic_bubbles_3 = false


# Save data to a file
func save_data():
	var config = ConfigFile.new()
	config.set_value("Player", "Money", player_money)
	
	config.set_value("Upgrades", "fish_bubbles_2", fish_bubbles_2)
	config.set_value("Upgrades", "fish_bubbles_3", fish_bubbles_3)
	config.set_value("Upgrades", "current_fish_bubbles", fish_bubbles_amount)
	
	config.set_value("Upgrades", "plastic_bubbles_2", plastic_bubbles_2)
	config.set_value("Upgrades", "plastic_bubbles_3", plastic_bubbles_3)
	config.set_value("Upgrades", "current_plastic_bubbles", plastic_bubbles_amount)
	
	
	config.set_value("Fish", "Caught", fish_caught)
	config.set_value("Fish", "Failed", failed_fish)
	config.set_value("Fish", "TotalCaught", total_fish_caught)
	config.set_value("Fish", "TotalFailed", total_failed_fish)
	config.set_value("Fish", "Price", fish_price)
	config.set_value("Fish", "Health", fish_health)
	config.set_value("Fish", "GrowthRate", fish_growth_rate)
	config.set_value("Fish", "Population", fish_population)
	

	config.set_value("Plastic", "Caught", plastic_caught)
	config.set_value("Plastic", "Failed", failed_plastic)
	config.set_value("Plastic", "TotalCaught", total_plastic_caught)
	config.set_value("Plastic", "TotalFailed", total_failed_plastic)
	config.set_value("Plastic", "GrowthRate", plastic_growth_rate)
	config.set_value("Plastic", "Population", plastic_population)
	
	
	config.set_value("FishingTutorial", "Wrong", wrongFishing_shown)
	config.set_value("FishingTutorial", "Generally", fishingGenerally_shown)
	
	config.set_value("CurrentTime", "Time", current_time_str)
	config.set_value("CurrentTime", "VariableUsed", time_variable_use)
	
	config.set_value("DayWeekEnd", "current_day_int", current_day_int)
	config.set_value("DayWeekEnd", "current_day_str", current_day_str)
	
	config.save(SAVE_PATH)

# Load data from a file
func load_data():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		player_money = config.get_value("Player", "Money", 100.0)  # Default to 1000 if not found
		
		fish_bubbles_2 = config.get_value("Upgrades", "fish_bubbles_2", false)
		fish_bubbles_3 = config.get_value("Upgrades", "fish_bubbles_3", false)
		fish_bubbles_amount = config.get_value("Upgrades", "current_fish_bubbles", 1)
		
		plastic_bubbles_2 = config.get_value("Upgrades", "plastic_bubbles_2", false)
		plastic_bubbles_3 = config.get_value("Upgrades", "plastic_bubbles_3", false)
		plastic_bubbles_amount = config.get_value("Upgrades", "current_plastic_bubbles", 1)
		
		fish_caught = config.get_value("Fish", "Caught", 0) 
		failed_fish = config.get_value("Fish", "Failed", 0)
		total_fish_caught = config.get_value("Fish", "TotalCaught", 0)
		total_failed_fish = config.get_value("Fish", "TotalFailed", 0)
		fish_price = config.get_value("Fish", "Price", 20)
		fish_health = config.get_value("Fish", "Health", 1)
		fish_growth_rate = config.get_value("Fish", "GrowthRate", 1.5)
		fish_population = config.get_value("Fish", "Population", 10)
		
		plastic_caught = config.get_value("Plastic", "Caught", 0) 
		failed_plastic = config.get_value("Plastic", "Failed", 0)
		total_plastic_caught = config.get_value("Plastic", "TotalCaught", 0)
		total_failed_plastic = config.get_value("Plastic", "TotalFailed", 0)
		plastic_growth_rate = config.get_value("Plastic", "GrowthRate", 3)
		plastic_population = config.get_value("Plastic", "Population", 5)
		
		wrongFishing_shown = config.get_value("FishingTutorial", "Wrong", false)
		fishingGenerally_shown = config.get_value("FishingTutorial", "Generally", false)
		
		current_time_str = config.get_value("CurrentTime", "Time", "Monday 00:00:00")
		time_variable_use = config.get_value("CurrentTime", "VariableUsed", 0)
		
		current_day_int = config.get_value("DayWeekEnd", "current_day_int", 0)
		current_day_str = config.get_value("DayWeekEnd", "current_day_str", "Monday")

#Functions to play with money variable
func add_money(amount: float):
	player_money += amount
	
func subtract_money(amount: float):
	if player_money >= amount:
		player_money -= amount
		
func get_money() -> float:
	return player_money
	


func fish_population_func():
	fish_population = fish_population - 1
	
func fish_growth_func():
	fish_population = round(fish_population * fish_growth_rate)
	
func fish_health_func():
	fish_health = fish_health - (plastic_population*0.05) # as per Pratik's python file
	fish_health = clamp(fish_health, 0, 1)
	
func fish_price_func():
	fish_price = fish_price * fish_health
	
func plastic_population_func():
	plastic_population = plastic_population - 1
	
func plastic_growth_func():
	plastic_population = plastic_population + plastic_growth_rate
	
	
	
# Functions to play with Fish
func fish_caught_func():
	fish_caught = fish_caught + 1
	
func total_caught_func():
	total_fish_caught = total_fish_caught + 1
	
func fish_failed_func():
	total_failed_fish = total_failed_fish + 1
	failed_fish = failed_fish + 1

func total_reset_func():
	total_fish_caught = 0
	
func fish_reset_func():
	fish_caught = 0
	
func fail_reset_func():
	failed_fish = 0
	
	
# Functions to play with Plastic
func plastic_caught_func():
	plastic_caught = plastic_caught + 1
	
func total_plastic_caught_func():
	total_plastic_caught = total_plastic_caught + 1
	
func plastic_failed_func():
	total_failed_plastic = total_failed_plastic + 1
	failed_plastic = failed_plastic + 1

func total_plastic_reset_func():
	total_plastic_caught = 0
	
func plastic_reset_func():
	plastic_caught = 0
	
func plastic_fail_reset_func():
	failed_plastic = 0
	
# Function to get the current money
func get_fish() -> float:
	return fish_caught
	
# Function to get the current money
func get_plastics() -> float:
		return plastic_caught

# Functions to play with Time	
func save_time():
	current_time_str = time_system.get_time()
	
func _exit_tree() -> void:
	time_system.log("game closed")
	GameData.save_time()
	time_variable_use = 0
	GameData.save_data()
	
func _enter_tree() -> void:
	time_system.log("game started")
	
func time_variable():
	time_variable_use = time_variable_use + 1
	GameData.save_data()


func purchase_fishbubble2():
	if not fish_bubbles_2:
		fish_bubbles_2 = true
		fish_bubbles_amount = 2

func purchase_fishbubble3():
	if not fish_bubbles_3 and fish_bubbles_2:
		fish_bubbles_3 = true
		fish_bubbles_amount = 3
		
func purchase_plasticbubble2():
	if not plastic_bubbles_2:
		plastic_bubbles_2 = true
		plastic_bubbles_amount = 2

func purchase_plasticbubble3():
	if not plastic_bubbles_3 and plastic_bubbles_2:
		plastic_bubbles_3 = true
		plastic_bubbles_amount = 3

## Day and Money
enum States {START, IDLE, END}
var state: States = States.END

var strike_counter = 0


func auto_deduction():
	var deduct: int = 50
	if state == States.END:
		if player_money < deduct:
			player_money = 0
			strike_counter += 1
			GameData.save_data()
			return false
		else:
			GameData.subtract_money(deduct)
			GameData.save_data()
			return true
	else:
		return true

func next_day():
	current_day_int = current_day_int + 1
	if(current_day_int >= 7):
		end_of_the_week()
		save_data()
	else:
		current_day_str = days_of_the_week[current_day_int]
		auto_deduction()
		save_data()
		end_day()

func resetDaycounter():
	current_day_int = -1
	current_day_str = days_of_the_week[current_day_int]

func end_day():
	get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
	current_day_int = current_day_int + 1
	save_data()
	
func end_of_the_week():
	current_day_int = 0
	get_tree().change_scene_to_file("res://415. WeekEnd/Scene/week_end.tscn")
	print("End of the Week")
	
func check_plastic_amount():
	return total_plastic_caught >= plastic_target
