extends PathFollow2D

var speed = 0.15

var start = false

func _process(delta):
	$PressE.visible = false
	if Global.dialog_finished == true :
		progress_ratio += delta*speed
	
	
	
	if progress_ratio == 1 and Input.is_action_just_released("action") :
		$PressE. visible = false
		Global.next_dialog = true
		Global.dialog_finished = false
	elif progress_ratio == 1 and not tutorial_var.second_finished and not Global.next_dialog:
		$PressE.visible = true
			
	
	
		
	
