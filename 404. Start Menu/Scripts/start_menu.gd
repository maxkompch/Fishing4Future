extends Control


func _process(delta):
	if(GameData.game_exists == true):
		$HBoxContainer/ContinueGame.visible = true
	else:
		$HBoxContainer/ContinueGame.visible = false

func _on_new_game_pressed() -> void:
	GameData.game_exists = true
	SceneTransition.transition()
	await SceneTransition.on_transition_finished
	get_tree().change_scene_to_file("res://401. Cut Scene/Scenes/court_scene1.tscn")
	print("new game")

func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://403. Options/Scenes/options_menu.tscn")
	print("option")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_continue_game_pressed() -> void:
	get_tree().change_scene_to_file("res://405. Start Area/scenes/start_area.tscn")
	print("continue")

		
