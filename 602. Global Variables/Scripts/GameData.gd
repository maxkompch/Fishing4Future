extends Node

# Strictly do not touch the above lines unless you are working with tutorials
var wrongFishing_shown = false
var fishingGenerally_shown = false
# Strictly do not touch the above lines unless you are working with tutorials

const SAVE_PATH = "user://save_data.cfg"
var player_money: float = 100.0

# Variables to track purchased upgrades
var rod1_purchased = false
var rod2_purchased = false
var rod3_purchased = false
var net1_purchased = false
var net2_purchased = false
var net3_purchased = false

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

var plastic_target: int = 7

var total_plastic_caught: int = 0
var total_failed_plastic: int = 0

var plastic_population: int = 0
var fish_population: int = 0

# Save data to a file
func save_data():
	var config = ConfigFile.new()
	config.set_value("Player", "Money", player_money)
	
	# Save purchased upgrades
	config.set_value("Upgrades", "Rod1", rod1_purchased)
	config.set_value("Upgrades", "Rod2", rod2_purchased)
	config.set_value("Upgrades", "Rod3", rod3_purchased)
	config.set_value("Upgrades", "Net1", net1_purchased)
	config.set_value("Upgrades", "Net2", net2_purchased)
	config.set_value("Upgrades", "Net3", net3_purchased)
	
	config.set_value("Fish", "Caught", fish_caught)
	config.set_value("Fish", "Failed", failed_fish)
	
	config.set_value("Total", "Caught", total_fish_caught)
	config.set_value("Total", "Failed", total_failed_fish)
	
	config.set_value("Fish", "Caught", fish_caught)
	config.set_value("Fish", "Failed", failed_fish)
	
	config.set_value("Total", "Caught", total_fish_caught)
	config.set_value("Total", "Failed", total_failed_fish)
	
	config.set_value("Wrong", "Fishing", wrongFishing_shown)
	config.set_value("Generally", "Fishing", fishingGenerally_shown)
	
	config.save(SAVE_PATH)

# Load data from a file
func load_data():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		player_money = config.get_value("Player", "Money", 1000.0)  # Default to 1000 if not found
		
		# Load purchased upgrades
		rod1_purchased = config.get_value("Upgrades", "Rod1", false)
		rod2_purchased = config.get_value("Upgrades", "Rod2", false)
		rod3_purchased = config.get_value("Upgrades", "Rod3", false)
		net1_purchased = config.get_value("Upgrades", "Net1", false)
		net2_purchased = config.get_value("Upgrades", "Net2", false)
		net3_purchased = config.get_value("Upgrades", "Net3", false)
		
		total_fish_caught = config.get_value("Total", "Caught",0)
		total_failed_fish = config.get_value("Total", "Failed",0)

		fish_caught = config.get_value("Fish", "Caught", 0)  # Default to 0 if not found
		failed_fish = config.get_value("Fish", "Failed", 0)  # Default to 0 if not found
		
		wrongFishing_shown = config.get_value("Wrong", "Fishing", false)
		fishingGenerally_shown = config.get_value("Generally", "Fishing", false)
# Function to add money
func add_money(amount: float):
	player_money += amount
	
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
	
# Function to subtract money
func subtract_money(amount: float):
	if player_money >= amount:
		player_money -= amount

# Function to get the current money
func get_money() -> float:
	return player_money

# Functions to update purchased states
func purchase_rod1():
	if not rod1_purchased:
		rod1_purchased = true

func purchase_rod2():
	if not rod2_purchased and rod1_purchased:
		rod2_purchased = true

func purchase_rod3():
	if not rod3_purchased and rod2_purchased:
		rod3_purchased = true

func purchase_net1():
	if not net1_purchased:
		net1_purchased = true

func purchase_net2():
	if not net2_purchased and net1_purchased:
		net2_purchased = true

func purchase_net3():
	if not net3_purchased and net2_purchased:
		net3_purchased = true
## Day and Money
enum States {START, IDLE, END}
var state: States = States.END

var strike_counter = 0

func auto_deduction():
	if state == States.END:
		GameData.subtract_money(80)
		GameData.save_data()
		if player_money < 0:
			player_money = 0
			strike_counter += 1
			GameData.save_data()
			return false
		else:
			return true
	else:
		return true
			
