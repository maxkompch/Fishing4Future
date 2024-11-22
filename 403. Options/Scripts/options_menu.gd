extends Control

func _on_volume_pressed() -> void:
	get_tree().change_scene_to_file("res://403. Options/Scenes/volume.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://404. Start Menu/Scenes/start_menu.tscn")
