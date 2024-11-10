extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_scene_transition_timer_timeout() -> void:
	print("Timer triggered")  # This should print when the timer reaches 2 seconds
	get_tree().change_scene_to_file("res://6. TextScrolls/Scenes/inside_shop.tscn")
