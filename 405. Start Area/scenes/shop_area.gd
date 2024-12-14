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
	if tutorial_var.is_tutorial == true:
		SceneTransition.transition()
		await SceneTransition.on_transition_finished
		get_tree().change_scene_to_file("res://413. Tutorial/Scenes/sea_area_tutorial.tscn")
	else:
		SceneTransition.transition()
		await SceneTransition.on_transition_finished
		if(GameData.current_day_str != time_system.get_time().split(" ")[0]):
			GameData.next_day()
			GameData.save_data()
		else:
			get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
		time_system.log("boat navigation")
	GameData.state = GameData.States.START
	pass
	

func _on_ship_exited(body):
	if tutorial_var.is_tutorial == true:
		SceneTransition.transition()
		await SceneTransition.on_transition_finished
		get_tree().change_scene_to_file("res://413. Tutorial/Scenes/end_start_area_tutorial.tscn")
	else:
		if (GameData.current_day_str != time_system.get_time().split(" ")[0]):
			GameData.current_day_int = GameData.current_day_int + 1
			GameData.current_day_str = GameData.days_of_the_week[GameData.current_day_int]
			SceneTransition.transition()
			await SceneTransition.on_transition_finished
			GameData.state = GameData.States.END
			time_system.log("day end")
			GameData.auto_deduction()
			GameData.save_data()
			GameData.end_day()
		else:
			get_tree().change_scene_to_file("res://405. Start Area/scenes/start_area.tscn")
			time_system.log("exit boat navigation")
			time_system.log("start scene")
		pass
	
