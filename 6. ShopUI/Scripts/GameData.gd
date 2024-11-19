extends Node

const SAVE_PATH = "user://save_data.cfg"
var player_money: float = 1000.0

# Variables to track purchased upgrades
var rod1_purchased = false
var rod2_purchased = false
var rod3_purchased = false
var net1_purchased = false
var net2_purchased = false
var net3_purchased = false

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

# Function to add money
func add_money(amount: float):
	player_money += amount

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
