extends Area2D

@export var slow_factor: float = 0.2  # How much to slow the player (0.5 = 50% speed)
@export var area_color: Color = Color(0.0, 0.3, 0.7, 0.3)  # Blue, semi-transparent

func _ready():
	# Connect the area's signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Create visual circle
	var area_shape = $CollisionShape2D
	if area_shape:
		var radius = area_shape.shape.radius if area_shape.shape is CircleShape2D else 50.0
		queue_redraw()

func _draw():
	var area_shape = $CollisionShape2D
	if area_shape and area_shape.shape is CircleShape2D:
		var radius = area_shape.shape.radius
		draw_circle(Vector2.ZERO, radius, area_color)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.enter_slow_area(slow_factor)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.exit_slow_area()
