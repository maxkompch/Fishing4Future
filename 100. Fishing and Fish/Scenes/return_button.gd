extends Button

func _ready():
	# Connect the button's pressed signal to our function
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	# Change scene back to main.tscn
	get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
	time_system.log("exit minigame")
	time_system.log("boat navigation")
