extends Control

enum DIFFICULTY {EASY, NORMAL, HARD}

var difficulty: DIFFICULTY = DIFFICULTY.HARD

func _ready() -> void:
	$MarginContainer/VBoxContainer/Difficulty.text = "HARD"
	
func _on_volume_pressed() -> void:
	get_tree().change_scene_to_file("res://403. Options/Scenes/volume.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://404. Start Menu/Scenes/start_menu.tscn")

func _on_difficulty_pressed() -> void:
	if difficulty == DIFFICULTY.EASY:
		$MarginContainer/VBoxContainer/Difficulty.text = "Normal"
		difficulty = DIFFICULTY.NORMAL
		GameData.difficulty_index = 1
		GameData.save_data()
	elif difficulty == DIFFICULTY.NORMAL:
		$MarginContainer/VBoxContainer/Difficulty.text = "Hard"
		difficulty = DIFFICULTY.HARD
		GameData.difficulty_index = 2
		GameData.save_data()
	elif difficulty == DIFFICULTY.HARD:
		$MarginContainer/VBoxContainer/Difficulty.text = "Easy"
		difficulty = DIFFICULTY.EASY
		GameData.difficulty_index = 0
		GameData.save_data()
