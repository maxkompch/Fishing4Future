# Created by Claude 3.5 Sonnet with the following prompt:
# Now create a fitting class for the user.
extends Node

class_name Fisher

# Player Statistics
@export var money: float = 1000.0
@export var experience: float = 0.0
@export var level: int = 1

# Inventory and Progress Tracking
var total_fish_caught: int = 0
var total_plastics_collected: int = 0
var achievements: Dictionary = {}
var inventory: Dictionary = {
	"bait": 0,
	"nets": 0,
	"repair_kits": 0
}

# References
var current_boat: FishingBoat = null

# Signals
signal money_changed(new_amount: float)
signal level_up(new_level: int)
signal experience_gained(amount: float)
signal achievement_unlocked(achievement_name: String)

func _ready():
	setup_achievements()

func setup_achievements():
	achievements = {
		"first_catch": {
			"name": "First Catch!",
			"description": "Catch your first fish",
			"unlocked": false
		},
		"plastic_hero": {
			"name": "Ocean Cleaner",
			"description": "Collect 100 pieces of plastic",
			"unlocked": false
		},
		"master_fisher": {
			"name": "Master Fisher",
			"description": "Reach level 10",
			"unlocked": false
		}
	}

func assign_boat(boat: FishingBoat):
	if current_boat:
		# Disconnect signals from old boat
		current_boat.catch_successful.disconnect(self._on_catch_successful)
		
	current_boat = boat
	# Connect signals from new boat
	current_boat.catch_successful.connect(self._on_catch_successful)

func _on_catch_successful(item_type: String):
	match item_type:
		"fish":
			total_fish_caught += 1
			add_experience(10.0)  # Base XP for fish
			if total_fish_caught == 1:
				unlock_achievement("first_catch")
		"plastics":
			total_plastics_collected += 1
			add_experience(5.0)  # Base XP for plastics
			if total_plastics_collected >= 100:
				unlock_achievement("plastic_hero")

func sell_cargo() -> float:
	if not current_boat:
		return 0.0
		
	var cargo = current_boat.unload_cargo()
	var earnings = calculate_earnings(cargo)
	add_money(earnings)
	return earnings

func calculate_earnings(cargo: Dictionary) -> float:
	# Base prices
	var fish_price = 10.0
	var plastics_price = 5.0
	
	# Apply level bonus (1% per level)
	var level_multiplier = 1.0 + (level - 1) * 0.01
	
	return (cargo["fish"] * fish_price + cargo["plastics"] * plastics_price) * level_multiplier

func add_money(amount: float):
	money += amount
	emit_signal("money_changed", money)

func spend_money(amount: float) -> bool:
	if money >= amount:
		money -= amount
		emit_signal("money_changed", money)
		return true
	return false

func add_experience(amount: float):
	experience += amount
	emit_signal("experience_gained", amount)
	check_level_up()

func check_level_up():
	var experience_needed = calculate_experience_needed()
	while experience >= experience_needed:
		earn_level_up()
		experience_needed = calculate_experience_needed()

func calculate_experience_needed() -> float:
	# Experience needed for next level increases exponentially
	return pow(level * 100, 1.2)

func earn_level_up():
	level += 1
	emit_signal("level_up", level)
	
	if level >= 10:
		unlock_achievement("master_fisher")

func unlock_achievement(achievement_id: String):
	if achievement_id in achievements and not achievements[achievement_id]["unlocked"]:
		achievements[achievement_id]["unlocked"] = true
		emit_signal("achievement_unlocked", achievements[achievement_id]["name"])

func upgrade_boat(attribute: String, amount: float) -> bool:
	if not current_boat:
		return false
		
	# Calculate upgrade cost based on current attribute value and amount
	var cost = calculate_upgrade_cost(attribute, amount)
	
	if spend_money(cost):
		current_boat.upgrade_attribute(attribute, amount)
		return true
	return false

func calculate_upgrade_cost(attribute: String, amount: float) -> float:
	# Base costs for different upgrades
	var base_costs = {
		"plastics_capacity": 100.0,
		"fish_capacity": 150.0,
		"movement_speed": 200.0,
		"fishing_speed": 250.0,
		"fishing_skill": 300.0
	}
	
	# Cost increases with level and amount
	var base_cost = base_costs.get(attribute, 100.0)
	return base_cost * amount * (1.0 + level * 0.1)

func buy_item(item: String, quantity: int = 1) -> bool:
	var item_costs = {
		"bait": 10.0,
		"nets": 50.0,
		"repair_kits": 75.0
	}
	
	if item in item_costs:
		var total_cost = item_costs[item] * quantity
		if spend_money(total_cost):
			inventory[item] += quantity
			return true
	return false

func use_item(item: String) -> bool:
	if item in inventory and inventory[item] > 0:
		inventory[item] -= 1
		
		match item:
			"repair_kit":
				if current_boat:
					current_boat.health = 100.0
			"bait":
				if current_boat:
					# Temporary fishing skill boost
					current_boat.fishing_skill *= 1.5
			"nets":
				if current_boat:
					# Temporary fishing speed boost
					current_boat.fishing_speed *= 0.75
		
		return true
	return false

func get_stats() -> Dictionary:
	return {
		"money": money,
		"level": level,
		"experience": experience,
		"total_fish": total_fish_caught,
		"total_plastics": total_plastics_collected,
		"achievements": achievements.keys().filter(func(k): return achievements[k]["unlocked"])
	}
