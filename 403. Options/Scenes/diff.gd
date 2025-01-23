extends Control


func _ready() -> void:
	pass


func _on_easy_pressed() -> void:
	GameData.difficulty_index = 0
	GameData.save_data()
	time_system.log("easy")
	get_tree().change_scene_to_file("res://416. Opening Scenes/Scenes/intro.tscn")


func _on_normal_pressed() -> void:
	GameData.difficulty_index = 1
	GameData.save_data()
	time_system.log("normal")
	get_tree().change_scene_to_file("res://416. Opening Scenes/Scenes/intro.tscn")


func _on_hard_pressed() -> void:
	GameData.difficulty_index = 2
	GameData.save_data()
	time_system.log("hard")
	get_tree().change_scene_to_file("res://416. Opening Scenes/Scenes/intro.tscn")
