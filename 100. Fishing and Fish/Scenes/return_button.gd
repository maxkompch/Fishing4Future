extends Button

func _ready():
	# Connect the button's pressed signal to our function
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	# Change scene back to main.tscn
	if tutorial_var.is_tutorial:
		time_system.log("sea area tutorial")
		get_tree().change_scene_to_file("res://413. Tutorial/Scenes/sea_area_tutorial.tscn")
	else:
		if(GameData.current_day_str != time_system.get_time().split(" ")[0]):
			pass
		else:
			get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
	time_system.log("exit minigame")
	time_system.log("boat navigation")
