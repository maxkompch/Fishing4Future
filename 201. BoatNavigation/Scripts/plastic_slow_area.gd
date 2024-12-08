extends Area2D

@export var vmax_factor: float = 0.2  # How much to slow the player (0.5 = 50% speed)

func _ready():
	# Connect the area's signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		time_system.log("enter plastic minigame")
		if tutorial_var.is_tutorial:
			#get_tree().change_scene_to_file("res://413. Tutorial/Scenes/tutorial_FishiMiniGame.tscn")
			get_tree().change_scene_to_file("res://100. Fishing and Fish/Scenes/PlasticMiniGame.tscn")
		else:
			get_tree().change_scene_to_file("res://100. Fishing and Fish/Scenes/PlasticMiniGame.tscn")
		body.enter_slow_area(vmax_factor)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.exit_slow_area()
