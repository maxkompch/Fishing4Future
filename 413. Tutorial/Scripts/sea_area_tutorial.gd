extends Node2D

func _process(delta):	
	
	if tutorial_var.third_finished == true and tutorial_var.fourth_finished == false:
		$Pfeil.visible = true
	else:
		$Pfeil.visible = false

		
