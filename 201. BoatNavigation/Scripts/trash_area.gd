extends "res://201. BoatNavigation/Scripts/slow_area.gd"


func _ready():
	# Connect the area's signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.enter_slow_area(vmax_factor)
		body.enter_trash_area()

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.exit_slow_area()
		body.exit_trash_area()
