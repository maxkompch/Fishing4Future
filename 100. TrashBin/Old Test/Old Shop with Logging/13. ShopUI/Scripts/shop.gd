extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_scene_transition_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://13. ShopUI/Scenes/inside_shop.tscn")
	print(Global.date_time.formatted_time + ": Entered Shop")
