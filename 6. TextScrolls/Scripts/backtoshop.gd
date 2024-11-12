extends Sprite2D


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://6. TextScrolls/Scenes/shop.tscn")
