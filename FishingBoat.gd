# Created by Claude 3.5 Sonnet with the following prompt:
# Write godot code that definers a user's boat in a fishing game. The boat has the attributes: plastics-capacity, fish-capacity, health, movement-speed, fishing-speed and fishing-skill.
extends CharacterBody2D

class_name FishingBoat

# Boat Attributes
@export var plastics_capacity: float = 100.0
@export var fish_capacity: float = 200.0
@export var health: float = 100.0
@export var movement_speed: float = 150.0
@export var fishing_speed: float = 1.0  # Time in seconds to catch a fish
@export var fishing_skill: float = 1.0   # Multiplier for catch success rate

# Current cargo amounts
var current_plastics: float = 0.0
var current_fish: float = 0.0

# Signals
signal capacity_full
signal health_changed(new_health: float)
signal catch_successful(item_type: String)

# State tracking
var is_fishing: bool = false
var fishing_timer: float = 0.0

func _ready():
	# Initialize any necessary components
	pass

func _physics_process(delta):
	# Handle movement
	var input = Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.y = Input.get_axis("move_up", "move_down")
	
	velocity = input.normalized() * movement_speed
	move_and_slide()

func start_fishing():
	if not is_fishing:
		is_fishing = true
		fishing_timer = 0.0

func stop_fishing():
	is_fishing = false
	fishing_timer = 0.0

func process_fishing(delta):
	if not is_fishing:
		return
		
	fishing_timer += delta
	if fishing_timer >= fishing_speed:
		attempt_catch()
		fishing_timer = 0.0

func attempt_catch():
	# Calculate catch success based on fishing_skill
	var success_chance = randf() * fishing_skill
	if success_chance > 0.5:  # Base 50% chance modified by skill
		var catch_type = determine_catch_type()
		add_to_cargo(catch_type)

func determine_catch_type():
	# 70% chance for fish, 30% for plastics
	return "fish" if randf() > 0.3 else "plastics"

func add_to_cargo(item_type: String):
	match item_type:
		"fish":
			if current_fish < fish_capacity:
				current_fish += 1.0
				emit_signal("catch_successful", "fish")
			else:
				emit_signal("capacity_full")
		"plastics":
			if current_plastics < plastics_capacity:
				current_plastics += 1.0
				emit_signal("catch_successful", "plastics")
			else:
				emit_signal("capacity_full")

func take_damage(amount: float):
	health = max(0.0, health - amount)
	emit_signal("health_changed", health)
	
	if health <= 0:
		handle_destruction()

func handle_destruction():
	# Handle boat destruction logic
	queue_free()

func unload_cargo() -> Dictionary:
	var cargo = {
		"fish": current_fish,
		"plastics": current_plastics
	}
	current_fish = 0.0
	current_plastics = 0.0
	return cargo

func upgrade_attribute(attribute: String, amount: float):
	match attribute:
		"plastics_capacity":
			plastics_capacity += amount
		"fish_capacity":
			fish_capacity += amount
		"movement_speed":
			movement_speed += amount
		"fishing_speed":
			fishing_speed = max(0.1, fishing_speed - amount)  # Lower is faster
		"fishing_skill":
			fishing_skill += amount
