extends Node2D

func _process(delta):	
	
	if tutorial_var.third_finished == true and tutorial_var.fourth_finished == false:
		$Pfeil.visible = true
	else:
		$Pfeil.visible = false
		$StaticBody2D/CollisionShape2D.disabled = false
		$StaticBody2D2/CollisionShape2D.disabled = false
		$StaticBody2D3/CollisionShape2D.disabled = false
		$StaticBody2D4/CollisionShape2D.disabled = false
		$StaticBody2D5/CollisionShape2D.disabled = true
