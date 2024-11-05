extends CharacterBody2D  # Changed from Node2D to enable built-in physics
var move_speed = 100
var current_velocity = Vector2.ZERO
var acceleration = 50
var deceleration = 100
var input_direction = Vector2.ZERO
# Collision signal variables
signal collision_occurred(object)
func _ready():
	print("Script initialized")
	# Connect button signals
	var btn_left = $UI/BoatControlUI/MidRow/btn_left
	var btn_right = $UI/BoatControlUI/MidRow/btn_right
	var btn_up = $UI/BoatControlUI/TopRow/btn_up
	var btn_down = $UI/BoatControlUI/ButtomRow/btn_down

	if btn_left and btn_right and btn_up and btn_down:
		btn_left.pressed.connect(_on_left_button_pressed)
		btn_left.button_up.connect(_on_left_button_released)
		btn_right.pressed.connect(_on_right_button_pressed)
		btn_right.button_up.connect(_on_right_button_released)
		btn_up.pressed.connect(_on_up_button_pressed)
		btn_up.button_up.connect(_on_up_button_released)
		btn_down.pressed.connect(_on_down_button_pressed)
		btn_down.button_up.connect(_on_down_button_released)
		print("Buttons connected successfully")
	else:
		print("Error: Some buttons not found!")
func physicsprocess(delta):
	if input_direction != Vector2.ZERO:
		print("Input direction: ", input_direction)

	# Apply acceleration based on input
	if input_direction != Vector2.ZERO:
		current_velocity += input_direction * acceleration * delta
		current_velocity = current_velocity.limit_length(move_speed)
		print("Current velocity: ", current_velocity)
	else:
		# Apply deceleration when no input
		if current_velocity.length() > 0:
			var decel_direction = -current_velocity.normalized()
			var decel_amount = deceleration * delta

			if current_velocity.length() <= decel_amount:
				current_velocity = Vector2.ZERO
			else:
				current_velocity += decel_direction * decel_amount

	# Set the velocity for move_and_slide
	velocity = current_velocity

	# Use move_and_slide instead of directly setting position
	move_and_slide()

	# Check for collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		handle_collision(collision)

	# Debug print for position
	if current_velocity != Vector2.ZERO:
		print("Player position: ", position)
func handle_collision(collision):
	var collider = collision.get_collider()
	print("Collision detected with: ", collider.name)

	# Emit signal for external handling
	collision_occurred.emit(collider)

	# Handle different types of collisions
	if collider.is_in_group("obstacles"):
		# Bounce off obstacles
		current_velocity = current_velocity.bounce(collision.get_normal())
		current_velocity *= 0.1  # Reduce velocity after collision
	elif collider.is_in_group("collectibles"):
		# Handle collectible interaction
		if collider.has_method("collect"):
			collider.collect()
	elif collider.is_in_group("damage_sources"):
		# Handle damage
		take_damage()
func take_damage():
	# Implement damage handling logic
	print("Damage taken!")
	# Add your damage logic here
# Button handling functions remain the same
func onleft_button_pressed():
	print("Left button pressed")
	input_direction.x = -1
func onright_button_pressed():
	print("Right button pressed")
	input_direction.x = 1
func onup_button_pressed():
	print("Up button pressed")
	input_direction.y = -1
func ondown_button_pressed():
	print("Down button pressed")
	input_direction.y = 1
func onleft_button_released():
	print("Left button released")
	if input_direction.x < 0:
		input_direction.x = 0
func onright_button_released():
	print("Right button released")
	if input_direction.x > 0:
		input_direction.x = 0
func onup_button_released():
	print("Up button released")
	if input_direction.y < 0:
		input_direction.y = 0
func ondown_button_released():
	print("Down button released")
	if input_direction.y > 0:
		input_direction.y = 0
