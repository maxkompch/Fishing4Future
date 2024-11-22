extends Control

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://13. Tutorial/Scenes/start_area_tutorial.tscn")

func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://11. Options/Scenes/options_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_continue_game_pressed() -> void:
	get_tree().change_scene_to_file("res://13. Tutorial/Scenes/start_area_tutorial.tscn")
