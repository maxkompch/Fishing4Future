extends Label

var time_passed = 0.0
var color_state = 1  # 0 for White, 1 for Blue, 2 for Black

func _ready():
	self.modulate = Color(0, 0, 1)
	set_process(true)

func _process(delta):
	time_passed += delta
	
	if time_passed >= 0.5:
		if color_state == 0:
			self.modulate = Color(0, 0, 1)  # Blue
		elif color_state == 1:
			self.modulate = Color(0, 0, 0)  # Black
		else:
			self.modulate = Color(1, 1, 1)  # White
		
		color_state = (color_state + 1) % 3  # Loop between 0, 1, and 2
		time_passed = 0.0 
