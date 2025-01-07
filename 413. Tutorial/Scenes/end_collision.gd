extends StaticBody2D

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tutorial_var.sixth_finished == true and tutorial_var.fifth_finished == true:
		$CollisionShape2D.disabled = false
