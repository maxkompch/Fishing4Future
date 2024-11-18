extends Node2D

var HookPosition = [] 
var Positionamount = 0
var currentPosition = 0
var winposition = 0
@onready var hook = $Hook
@onready var label = $Label
@onready var mytimer = $Timer
enum Ministate{running, stopped}
var currentState = Ministate.running

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HookPosition.append_array(find_children("Position*","",true,true))
	Positionamount = HookPosition.size()
	winposition = floor(Positionamount * randf())
	print(str(winposition) + "is the Winpositon")
	HookPosition[winposition].modulate = Color(0,1,0,1)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match currentState:
		Ministate.running:
			pass
		Ministate.stopped:
			mytimer.stop()
	pass

func _on_timer_timeout() -> void:
	currentPosition += 1
	if(currentPosition >= Positionamount):
		currentPosition = 0
	hook.position = HookPosition[currentPosition].position
	pass # Replace with function body.

func Fishfang() -> void:
	if(currentPosition == winposition):
		label.text = "you won"
	else:
		label.text = "you lose"

func _on_hook_the_fish_button_up() -> void:
	match currentState:
		Ministate.running:
			Fishfang()
			currentState = Ministate.stopped
			pass
		Ministate.stopped:
			label.text = "MiniGame running"
			currentState = Ministate.running
			mytimer.start()
			pass
	pass # Replace with function body.
