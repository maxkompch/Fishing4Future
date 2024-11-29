extends PathFollow2D

var speed = 0.15
var new_dialog = true

func _process(delta):
	$PressE.visible = false
	if tutorial_var.first_finished == true :
		progress_ratio += delta*speed
	
	if progress_ratio == 1 and tutorial_var.second_finished == false and new_dialog == true:
		$PressE.visible = true
		if Input.is_action_just_released("action"):
			tutorial_var.next_dialog = true
			$PressE.visible = false
			new_dialog = false
	
