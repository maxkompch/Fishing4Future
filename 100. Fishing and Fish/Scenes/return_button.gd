extends Button

func _ready():
	# Connect the button's pressed signal to our function
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	# Change scene back to main.tscn
	if tutorial_var.is_tutorial == true:
		get_tree().change_scene_to_file("res://413. Tutorial/Scenes/sea_area_tutorial.tscn")
	else:
		get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
