extends CharacterBody2D

# Boat Attributes
@export var plastics_capacity: float = 20.0
@export var fish_capacity: float = 20.0
@export var health: float = 100.0
@export var max_speed: float = 150.0
@export var acceleration: float = 200.0
@export var deceleration: float = 150.0

# Speed modifier
var speed_modifier: float = 1.0
var target_modifier: float = 1.0
var modifier_change_rate: float = 2.0  # How fast the speed modifier changes

# Variables
var current_plastics = GameData.get_plastics()
var current_fish = GameData.get_fish()
var input_vector = Vector2.ZERO
var current_speed = Vector2.ZERO
var whirl_vector = Vector2.ZERO
var whirl_center = Vector2.ZERO
var whirl_strength = 0.0
var prompt_label: Label

# Signals
signal capacity_full
signal health_changed(new_health: float)
signal catch_successful(item_type: String)
signal entered_slow_area
signal exited_slow_area
signal entered_whirl_area
signal exited_whirl_area
signal entered_fishing_area
signal exited_fishing_area
signal entered_trash_area
signal exited_trash_area

# State tracking
var in_fishing_area = false
var in_trash_area = false
var in_return_home_area = false
var in_whirl = false

func _ready():
	add_to_group("player")
	prompt_label = Label.new()
	prompt_label.text = "Press E"
	prompt_label.z_index = 5
	prompt_label.visible = false
	add_child(prompt_label)
	
func _process(delta: float) -> void:
	
	if in_fishing_area and Input.is_action_just_released("action"):
		get_tree().change_scene_to_file("res://100. Fishing and Fish/Scenes/FishiMiniGame.tscn")
		
	if in_trash_area and Input.is_action_just_released("action"):
		get_tree().change_scene_to_file("res://100. Fishing and Fish/Scenes/PlasticMiniGame.tscn")
		
	if in_return_home_area and Input.is_action_just_released("action"):
		if tutorial_var.is_tutorial:
			get_tree().change_scene_to_file("res://413. Tutorial/Scenes/end_start_area_tutorial.tscn")
		else:
			get_tree().change_scene_to_file("res://405. Start Area/scenes/start_area.tscn")

func _physics_process(delta):
	# Get input vector from the built-in actions
	input_vector.x = Input.get_axis("left", "right")
	input_vector.y = Input.get_axis("up", "down")
	
	# Normalize the vector to prevent faster diagonal movement
	input_vector = input_vector.normalized()
	
	# Update speed modifier
	speed_modifier = move_toward(speed_modifier, target_modifier, modifier_change_rate * delta)
	
	# Update whirl effect if in whirl
	if in_whirl:
		var direction_to_center = global_position.direction_to(whirl_center)
		var distance_to_center = global_position.distance_to(whirl_center)
		# Increase pull strength as boat gets closer to center
		var pull_strength = whirl_strength * (1.0 + 1.0 / max(distance_to_center, 1.0))
		whirl_vector = direction_to_center * pull_strength
	
	# Handle acceleration and deceleration with modifier
	var target_velocity = input_vector * (max_speed * speed_modifier)
	
	if input_vector != Vector2.ZERO:
		# Accelerate
		current_speed = current_speed.move_toward(target_velocity + whirl_vector * max_speed, acceleration * delta)
	else:
		# Apply whirl force even when no input
		current_speed = current_speed.move_toward(whirl_vector * max_speed, acceleration * delta)
	
	# Apply movement
	velocity = current_speed
	move_and_slide()

func enter_slow_area(vmax_factor: float):
	target_modifier = vmax_factor
	emit_signal("entered_slow_area")

func exit_slow_area():
	target_modifier = 1.0
	emit_signal("exited_slow_area")

func enter_fishing_area():
	emit_signal("entered_fishing_area")
	in_fishing_area = true
	prompt_label.visible = true

func exit_fishing_area():
	emit_signal("exited_fishing_area")
	in_fishing_area = false
	prompt_label.visible = false
	
func enter_trash_area():
	emit_signal("entered_trash_area")
	in_trash_area = true
	prompt_label.visible = true

func exit_trash_area():
	emit_signal("exited_slow_area")
	in_trash_area = false
	prompt_label.visible = false
	
func enter_return_home_area():
	emit_signal("entered_return_home_area")
	in_return_home_area = true
	prompt_label.visible = true

func exit_return_home_area():
	emit_signal("exited_return_home_area")
	in_return_home_area = false
	prompt_label.visible = false
	
func enter_whirl_area(center: Vector2, acc_factor: float, vmax_factor: float):
	whirl_center = center
	whirl_strength = acc_factor
	target_modifier = vmax_factor
	in_whirl = true
	emit_signal("entered_whirl_area")

func exit_whirl_area():
	in_whirl = false
	whirl_vector = Vector2.ZERO
	target_modifier = 1.0
	emit_signal("exited_whirl_area")

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

# TODO add damage threw objects
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
