extends Node2D

var HookPosition = [] 
var Positionamount = 0
var currentPosition = 0
var winposition = 0
@onready var hook = $Hook
@onready var label = $Label
@onready var mytimer = $Timer
@onready var logger = $Logger
enum Ministate{running, stopped}
var currentState = Ministate.running

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HookPosition.append_array(find_children("Position*","",true,true))
	Positionamount = HookPosition.size()
	winposition = floor(Positionamount * randf())
	print(str(winposition) + "is the Winpositon")
	logger.logdata("winposition",str(winposition))
	HookPosition[winposition].modulate = Color(0,1,0,1)
	logger.logdata("minigamestart","start")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tutorial_var.is_tutorial == true and tutorial_var.sixth_finished == false:
		$fishingGenerally.visible = true
		$wrongFishing.visible = false
	hook.position = HookPosition[currentPosition].position
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
	
	pass # Replace with function body.

func Fishfang() -> void:
	if(currentPosition == winposition):
		label.text = "you won"
		logger.logdata("playerhit","you win")
<<<<<<< Updated upstream
=======
		if tutorial_var.is_tutorial == true:
			if tutorial_var.sixth_finished == false and tutorial_var.fifth_finished == true and tutorial_var.fished_once == true:
				tutorial_var.plastic_fished = true
			else:
				tutorial_var.fished_once = true
			
		if(GameData.fish_caught >= GameData.max_fish):
			GameData.fish_reset_func()
			GameData.save_data()
			if tutorial_var.is_tutorial == true:
				get_tree().change_scene_to_file("res://413. Tutorial/Scenes/sea_area_tutorial.tscn")
				tutorial_var.fish_spot_exited = true
			else:
				get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
>>>>>>> Stashed changes
	else:
		label.text = "you lose"
		logger.logdata("playerhit","you lose")
<<<<<<< Updated upstream
=======
		if(GameData.failed_fish >= GameData.max_fail):
			GameData.fail_reset_func()
			GameData.save_data()
			if tutorial_var.is_tutorial == true:
				get_tree().change_scene_to_file("res://413. Tutorial/Scenes/sea_area_tutorial.tscn")
				tutorial_var.fish_spot_exited = true
			else:
				get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
>>>>>>> Stashed changes

func _on_hook_the_fish_button_up() -> void:
	match currentState:
		Ministate.running:
			Fishfang()
			currentState = Ministate.stopped
			pass
		Ministate.stopped:
			label.text = "MiniGame running"
			currentState = Ministate.running
			logger.logdata("minigamestart","restart")
			mytimer.start()
			pass
	pass # Replace with function body.
