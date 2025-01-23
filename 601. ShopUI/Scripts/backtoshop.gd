extends Sprite2D


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
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
			time_system.log("exit shop")
			time_system.log("day end")
			time_system.log("start scene")
			get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
	else:
		time_system.log("exit shop")
		get_tree().change_scene_to_file("res://405. Start Area/scenes/shop_start.tscn")
