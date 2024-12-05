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
	time_system.log("shop transition")
	pass # Replace with function body.

func on_ship_entered(body):
	get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
	GameData.state = GameData.States.START
	time_system.log("boat navigation")
	pass
	

func _on_ship_exited(body):
	get_tree().change_scene_to_file("res://405. Start Area/scenes/start_area.tscn")
	GameData.state = GameData.States.END
	time_system.log("exit boat navigation")
	time_system.log("start scene")
	pass # Replace with function body.
