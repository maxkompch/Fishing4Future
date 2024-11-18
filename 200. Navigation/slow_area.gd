extends Area2D

@export var slow_factor: float = 0.05  # How much to slow the player (0.5 = 50% speed)
@export var area_color: Color = Color(0.0, 0.3, 0.7, 0.3)  # Blue, semi-transparent

func _ready():
	# Connect the area's signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Create visual srectangle
	var area_shape = $CollisionShape2D
	if area_shape:
		var shape_size = area_shape.shape.size if area_shape.shape is RectangleShape2D else Vector2(100, 100)
		queue_redraw()

func _draw():
	var area_shape = $CollisionShape2D
	if area_shape and area_shape.shape is RectangleShape2D:
		var rect_size = area_shape.shape.size
		var rect = Rect2(-rect_size/2, rect_size)
		draw_rect(rect, area_color)

func _on_body_entered(body):
	if body.is_in_group("boat_player"):
		body.enter_slow_area(slow_factor)

func _on_body_exited(body):
	if body.is_in_group("boat_player"):
		body.exit_slow_area()
