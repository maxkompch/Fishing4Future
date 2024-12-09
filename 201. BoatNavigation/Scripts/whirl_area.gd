extends Area2D

@export var acc_factor: float = 0.4 # Force of acceleration towards center
@export var vmax_factor: float = 1.5  # How much to slow the player (0.5 = 50% speed)
@export var rotation_speed: float = 0.1  # Rotations per second

# Store the global center position
var center: Vector2 = Vector2.ZERO

func _ready():
	# Connect the area's signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Calculate the global center position
	center = global_position + $CollisionShape2D.position
	
	# If you want to update the center position when the whirl moves
	# Uncomment the next line
	# set_process(true)

# Optional: Update center position if the whirl can move
func _process(delta: float):
	# Rotate the Area2D by converting rotation_speed to radians
	rotate(rotation_speed * TAU * delta)
	center = global_position + $CollisionShape2D.position

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Pass the current global center position
		body.enter_whirl_area(center, acc_factor, vmax_factor)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.exit_whirl_area()
