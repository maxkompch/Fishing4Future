extends PathFollow2D

var speed = 0.15

var start = false

func _process(delta):
	if Global.dialog_finished == true :
		progress_ratio += delta*speed
	
	if progress_ratio == 1 and Input.is_action_just_released("action"):
		Global.next_dialog = true
		Global.dialog_finished = false
	
		
	
