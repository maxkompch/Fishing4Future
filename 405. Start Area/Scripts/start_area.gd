extends Node2D

func _process(delta):
	if tutorial_var.is_tutorial == true:
		$CharacterBody2D2.visible = false
	else:
		$CharacterBody2D2.visible = true
