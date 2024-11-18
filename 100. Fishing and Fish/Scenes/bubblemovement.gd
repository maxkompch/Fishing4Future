extends Node2D

var time = 0
@export var middle = 0
@export var amplitide = 0
@export var offset : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = time + offset
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time = time + delta
	position.y = amplitide * sin(time*1.5) + middle
	pass
