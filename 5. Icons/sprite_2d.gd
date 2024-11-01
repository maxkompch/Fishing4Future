extends Sprite2D

var deltakeep = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	deltakeep += delta
	position.y = sin(deltakeep)*100 + 200
	print(position.y)
	pass
