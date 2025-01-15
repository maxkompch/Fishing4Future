extends Node2D

@onready var screen = $AwhitePixel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var normalized_time = date_time.normalized_hours
	
	if (normalized_time > 0.6):
		var screenvisibility = (normalized_time*0.34)
		screen.modulate = Color(0,0.141,0.329,screenvisibility)
	elif(normalized_time < 0.3):
		screen.modulate = Color(0,0.141,0.329,((1-normalized_time-0.5)*0.34))
	else:
		screen.modulate = Color(0,0.141,0.329,0)
	pass
