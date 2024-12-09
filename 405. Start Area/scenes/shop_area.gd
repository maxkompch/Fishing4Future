extends Area2D

var current_day: int = 1
var previous_day = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	previous_day = time_system.get_time().split(" ")[0]
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
		#SceneTransition.transition()
		#await SceneTransition.on_transition_finished
		get_tree().change_scene_to_file("res://413. Tutorial/Scenes/sea_area_tutorial.tscn")
	else:
		SceneTransition.transition()
		await SceneTransition.on_transition_finished
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
		var current_day = time_system.get_time().split(" ")[0]
		if current_day != previous_day:
			previous_day = current_day
			SceneTransition.transition()
			await SceneTransition.on_transition_finished
			get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
			GameData.state = GameData.States.END
			time_system.log("day end")
		else:
			get_tree().change_scene_to_file("res://405. Start Area/scenes/start_area.tscn")
			time_system.log("exit boat navigation")
			time_system.log("start scene")
		pass
	
