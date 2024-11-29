extends PathFollow2D

var speed = 0.15


func _process(delta):
	tutorial_var.start_talking = false
	if progress_ratio <= 0.45 and progress_ratio > 0.40 and tutorial_var.seventh_finished == false:
			tutorial_var.start_talking = true
	elif(tutorial_var.start_talking == false):
		progress_ratio += delta*speed
	
		

	
