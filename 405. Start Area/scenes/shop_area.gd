extends Area2D

func _ready():
	GameData.load_data()
	set_process(true) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	get_tree().change_scene_to_file("res://601. ShopUI/Scenes/shop.tscn")
	GameData.state = GameData.States.IDLE
	time_system.log("shop transition")
	pass # Replace with function body.

func on_ship_entered(body):
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
				GameData.save_data()
				time_system.log("day end")
				get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
			#GameData.current_day_int = GameData.current_day_int + 1
			#GameData.current_day_str = GameData.days_of_the_week[GameData.current_day_int]
			#GameData.save_data()
			#time_system.log("day end")
			#get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
		else:
			time_system.log("exit start area")
			time_system.log("boat navigation")
			get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")

func _on_ship_exited(body):
	if tutorial_var.is_tutorial:
		time_system.log("end start area tutorial")
		get_tree().change_scene_to_file("res://413. Tutorial/Scenes/end_start_area_tutorial.tscn")
	else:
		if(GameData.current_day_str != time_system.get_time().split(" ")[0]):
			GameData.current_day_int = GameData.current_day_int + 1
			GameData.current_day_str = GameData.days_of_the_week[GameData.current_day_int]
			GameData.save_data()
			time_system.log("day end")
			get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
		else:
			get_tree().change_scene_to_file("res://405. Start Area/scenes/start_area.tscn")
