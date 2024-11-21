extends Area2D

@export var whirl_factor: float = -10 # Force of acceleration towards center
@export var acc_factor: float = 0.5  # Force of acceleration towards center

var center: Vector2 = Vector2.ZERO

func _ready():
	# Connect the area's signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	center = $CollisionShape2D.position
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.enter_whirl_area(center, whirl_factor, acc_factor)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.exit_whirl_area()
