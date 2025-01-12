extends CharacterBody2D

@export var move_speed: float = 150
@export var audiostream: AudioStreamPlayer2D = null

func _ready():
	audiostream.stream_paused = true

func _physics_process(_delta: float) -> void:
	# Get Input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if(input_direction != Vector2.ZERO):
		if(audiostream.playing == false):
			audiostream.play()
		audiostream.stream_paused = false
	else:
		audiostream.stream_paused = true
	#print(input_direction)
	
	# Update velocity
	velocity = input_direction * move_speed
	
	# Move and Slide function uses velocity of character body to move character in map
	move_and_slide()
