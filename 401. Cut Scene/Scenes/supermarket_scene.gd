extends Node2D

func _on_timer_timeout() -> void:
	SceneTransitionLight.transition()
	await SceneTransitionLight.on_transition_finished
	get_tree().change_scene_to_file("res://401. Cut Scene/Scenes/court_scene2.tscn")
