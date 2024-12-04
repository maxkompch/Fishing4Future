extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	get_tree().change_scene_to_file("res://601. ShopUI/Scenes/shop.tscn")
	GameData.state = GameData.States.IDLE
	pass # Replace with function body.

func on_ship_entered(body):
	get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
	GameData.state = GameData.States.START
	pass
	

func _on_ship_exited(body):
	get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
	GameData.state = GameData.States.END
	pass # Replace with function body.
