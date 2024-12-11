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
	GameData.plastic_reset_func()
	GameData.plastic_fail_reset_func()
	GameData.save_data()
	GameData.load_data()
	HookPosition.append_array(find_children("Position*","",true,true))
	Positionamount = HookPosition.size()
	winposition = floor(Positionamount * randf())
	print(str(winposition) + " is the plastic Winpositon")
	time_system.log("plastic winposition = "  + str(winposition))
	HookPosition[winposition].modulate = Color(0,1,0,1)
	time_system.log("plastic minigame start")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
		if(GameData.plastic_population >= 1):
			GameData.plastic_caught_func()
			GameData.total_plastic_caught_func()
			GameData.plastic_population_func()
			GameData.save_data()
			label.text = "Congratulation! You have caught " + str(GameData.total_plastic_caught) + " plastic(s). Auto close after catching " + str(GameData.max_plastic-GameData.plastic_caught) + " more plastics."
			time_system.log("plastic caught")
			if(GameData.plastic_caught >= GameData.max_plastic):
				GameData.plastic_reset_func()
				GameData.save_data()
				get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
		else:
			label.text = "                           Nice! No more plastic left to catch.                           "
			time_system.log("no plastic left")
	else:
		GameData.plastic_failed_func()
		GameData.save_data()
		label.text = "                Uh Oh! You have lost " + str(GameData.failed_plastic) + " times. Auto close after losing " + str(GameData.max_plastic_fail-GameData.failed_plastic) + " times."
		time_system.log("catching plastic failed")
		if(GameData.failed_plastic >= GameData.max_plastic_fail):
			GameData.plastic_fail_reset_func()
			GameData.save_data()
			get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")

func _on_hook_the_fish_button_up() -> void:
	match currentState:
		Ministate.running:
			Fishfang()
			currentState = Ministate.stopped
			pass
		Ministate.stopped:
			currentState = Ministate.running
			time_system.log("plastic minigame restart")
			mytimer.start()
			pass
	pass # Replace with function body.
