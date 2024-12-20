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
			if GameData.current_day_int == 6:
				GameData.end_of_the_week()
			else:
				GameData.current_day_int = GameData.current_day_int + 1
				GameData.current_day_str = GameData.days_of_the_week[GameData.current_day_int]
				GameData.plastic_growth_func()
				GameData.fish_growth_func()
				GameData.fish_health_func()
				GameData.fish_price_func()
				GameData.save_data()
				time_system.log("exit minigame")
				time_system.log("day end")
				time_system.log("start scene")
				get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
		else:
			time_system.log("exit minigame")
			time_system.log("boat navigation")
			get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
