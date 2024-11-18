extends Label

var time_passed = 0.0
var is_black = true

func _ready():
	# Start the color animation
	set_process(true)

func _process(delta):
	time_passed += delta
	
	# Change color every half second
	if time_passed >= 0.5:
		if is_black:
			self.modulate = Color(0, 0, 1)  # Blue
		else:
			self.modulate = Color(0, 0, 0)  # Black
		
		is_black = !is_black  # Toggle color
		time_passed = 0.0  # Reset timer
