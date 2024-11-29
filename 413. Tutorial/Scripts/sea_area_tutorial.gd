extends Node2D

func _process(delta):	
	
	
	if tutorial_var.third_finished == true and tutorial_var.fourth_finished == false:
		$Pfeil.visible = true
	elif tutorial_var.fifth_finished == true and tutorial_var.sixth_finished == false:
		$Pfeil2.visible = true
		$Pfeil.visible = false
		$Pfeil3.visible = false
	elif tutorial_var.sixth_finished == true:
		$Pfeil2.visible = false
		$Pfeil.visible = false
		$Pfeil3.visible = true
	else:
		$Pfeil2.visible = false
		$Pfeil.visible = false
		$Pfeil3.visible = false
		
