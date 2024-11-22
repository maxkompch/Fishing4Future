extends CharacterBody2D

# Boat Attributes
@export var plastics_capacity: float = 100.0
@export var fish_capacity: float = 200.0
@export var health: float = 100.0
@export var max_speed: float = 150.0
@export var acceleration: float = 200.0
@export var deceleration: float = 150.0
@export var fishing_speed: float = 1.0
@export var fishing_skill: float = 1.0

# Speed modifier
var speed_modifier: float = 1.0
var target_modifier: float = 1.0
var modifier_change_rate: float = 2.0  # How fast the speed modifier changes

# Variables
var current_plastics: float = 0.0
var current_fish: float = 0.0
var input_vector = Vector2.ZERO
var current_speed = Vector2.ZERO
var whirl_vector = Vector2.ZERO

# Signals
signal capacity_full
signal health_changed(new_health: float)
signal catch_successful(item_type: String)
signal entered_slow_area
signal exited_slow_area
signal entered_whirl_area
signal exited_whirl_area

# State tracking
var is_fishing: bool = false
var fishing_timer: float = 0.0

func _ready():
	add_to_group("player")

func _physics_process(delta):
	# Get input vector from the built-in actions
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	# Normalize the vector to prevent faster diagonal movement
	input_vector = input_vector.normalized()
	# Update speed modifier
	speed_modifier = move_toward(speed_modifier, target_modifier, modifier_change_rate * delta)
	
	# Handle acceleration and deceleration with modifier
	var target_velocity = (input_vector + whirl_vector) * (max_speed * speed_modifier)
	
	if input_vector != Vector2.ZERO:
		# Accelerate
		current_speed = current_speed.move_toward(target_velocity+whirl_vector, acceleration * delta)
	else:
		# Decelerate
		current_speed = current_speed.move_toward(Vector2.ZERO+whirl_vector, deceleration * delta)
	
	# Apply movement
	velocity = current_speed
	move_and_slide()
	
	# Process fishing if active
	if is_fishing:
		process_fishing(delta)

func enter_slow_area(slow_factor: float):
	target_modifier = slow_factor
	emit_signal("entered_slow_area")

func exit_slow_area():
	target_modifier = 1.0
	emit_signal("exited_slow_area")
	
func enter_whirl_area(center: Vector2, whirl_factor: float, acc_factor: float):
	whirl_vector =  -($CollisionShape2D.position.direction_to(center)).normalized()
	target_modifier = 1 + (acc_factor / (center.distance_to($CollisionShape2D.position)))
	deceleration = -deceleration
	emit_signal("enter_whirl_area")

func exit_whirl_area():
	target_modifier = 1.0
	whirl_vector = Vector2.ZERO
	deceleration = -deceleration
	emit_signal("exit_whirl_area")

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
	var success_chance = randf() * fishing_skill
	if success_chance > 0.5:
		var catch_type = determine_catch_type()
		add_to_cargo(catch_type)

func determine_catch_type():
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
		"max_speed":
			max_speed += amount
		"acceleration":
			acceleration += amount
		"fishing_speed":
			fishing_speed = max(0.1, fishing_speed - amount)
		"fishing_skill":
			fishing_skill += amount
