extends Node2D

var HookPosition = [] 
var Positionamount = 0
var currentPosition:int = 0
var winposition = []
@onready var hook = $Hook
@onready var label = $Label
@onready var mytimer = $Timer
@onready var logger = $Logger
enum Ministate{running, stopped}
var currentState = Ministate.running
var back_scene
var amount_Green_bubbles: int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if tutorial_var.is_tutorial:
		back_scene= "res://413. Tutorial/Scenes/sea_area_tutorial.tscn"
	else:
		back_scene = "res://201. BoatNavigation/Scenes/BoatNavigation.tscn"
		
	amount_Green_bubbles = GameData.fish_bubbles_amount
	GameData.fish_reset_func()
	GameData.fail_reset_func()
	GameData.save_data()
	GameData.load_data()
	HookPosition.append_array(find_children("Position*","",true,true))
	Positionamount = HookPosition.size()
	
	var used_positions := []
	while winposition.size() < amount_Green_bubbles and winposition.size() < Positionamount:
		var rand_position = int(floor(Positionamount * randf()))
		if rand_position not in used_positions:
			winposition.append(rand_position)
			used_positions.append(rand_position)
	
	print(str(winposition) + " is the fishing winpostion")
	for i in winposition:
		HookPosition[i].modulate = Color(0, 1, 0, 1)
		time_system.log("Fishing winposition " + str(i))
	
	time_system.log("fishing minigame start")
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
	if(currentPosition in winposition):
		if(GameData.fish_population >= 1):
			GameData.fish_caught_func()
			GameData.total_caught_func()
			GameData.fish_population_func()
			GameData.save_data()
			
			if tutorial_var.is_tutorial == true:
				tutorial_var.fished_once = true
			
			label.text = "Congratulation! You have caught " + str(GameData.total_fish_caught) + " fish. Auto close after catching " + str(GameData.max_fish-GameData.fish_caught) + " more fish."
			time_system.log("fish caught")
			if(GameData.fish_caught >= GameData.max_fish):
				GameData.fish_reset_func()
				GameData.save_data()
				get_tree().change_scene_to_file(back_scene)
		else:
			label.text = "                           Uh Oh! No fish left to catch.                           "
			time_system.log("no fish left")
	else:	
		print("current postion is :" + str(currentPosition))
		print("current win is :" + str(currentPosition in winposition))
		GameData.fish_failed_func()
		GameData.save_data()
		label.text = "                Uh Oh! You have lost " + str(GameData.failed_fish) + " times. Auto close after losing " + str(GameData.max_fail-GameData.failed_fish) + " times."
		time_system.log("catching fish failed")
		if(GameData.failed_fish >= GameData.max_fail):
			GameData.fail_reset_func()
			GameData.save_data()
			get_tree().change_scene_to_file(back_scene)

func _on_hook_the_fish_button_up() -> void:
	match currentState:
		Ministate.running:
			Fishfang()
			currentState = Ministate.stopped
			pass
		Ministate.stopped:
			currentState = Ministate.running
			time_system.log("fishing minigame restart")
			mytimer.start()
			pass
	pass # Replace with function body.
