extends Node2D

func _ready():
	pass

func _process(delta):
	$PressE.visible = false
			
		
	


func _on_chat_area_body_exited(body) -> void:
	$PressE.visible = false
	



func _on_chat_area_body_entered(body) -> void:
	if tutorial_var.second_finished == false and tutorial_var.first_finished == true:
		$PressE.visible = true
# Replace with function body.
