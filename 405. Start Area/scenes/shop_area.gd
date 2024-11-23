extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	get_tree().change_scene_to_file("res://601. ShopUI/Scenes/shop.tscn")
	pass # Replace with function body.

func on_ship_entered(body):
	get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
	pass
	
func on_ship_exited(body):
	get_tree().change_scene_to_file("res://405. Start Area/scenes/start_area.tscn")
	pass
