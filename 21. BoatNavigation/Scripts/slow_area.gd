extends Area2D

@export var slow_factor: float = 0.2  # How much to slow the player (0.5 = 50% speed)

func _ready():
	# Connect the area's signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.enter_slow_area(slow_factor)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.exit_slow_area()
