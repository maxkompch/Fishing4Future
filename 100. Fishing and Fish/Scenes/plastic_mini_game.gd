extends Node2D

var HookPosition = [] 
var Positionamount = 0
var currentPosition :int = 0
var winposition = []
@onready var hook = $Hook
@onready var label = $Label
@onready var mytimer = $Timer
@onready var logger = $Logger
@onready var sound_positive = $"good sound"
@onready var sound_negativ =$"bad sound"
enum Ministate{running, stopped}
var currentState = Ministate.running
var amount_Green_bubbles: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	amount_Green_bubbles = GameData.plastic_bubbles_amount
	
	GameData.plastic_reset_func()
	GameData.plastic_fail_reset_func()
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
	
	print(str(winposition) + " is the plastic winpostion")
	for i in winposition:
		HookPosition[i].modulate = Color(0, 1, 0, 1)
		time_system.log("Plastic winposition " + str(i))
	
	time_system.log("plastic minigame start")
	$PlasticItem3.visible = false
	if(GameData.plastic_caught == 1):
		$PlasticItem4.visible = false
	if(GameData.plastic_caught == 2):
		$PlasticItem4.visible = false
		$PlasticItem2.visible = false
	
	#if GameData.plastic_population >= 3:
		#if(GameData.plastic_caught == 1):
			#$PlasticItem4.visible = false
		#if(GameData.plastic_caught == 2):
			#$PlasticItem4.visible = false
			#$PlasticItem2.visible = false
	#elif GameData.plastic_population == 2:
		#$PlasticItem4.visible = false
		#if(GameData.plastic_caught == 1):
			#$PlasticItem4.visible = false
			#$PlasticItem2.visible = false
		#if(GameData.plastic_caught >= 2):
			#$PlasticItem4.visible = false
			#$PlasticItem2.visible = false
			#$PlasticItem.visible = false
	#elif GameData.plastic_population == 1:
		#$PlasticItem2.visible = false
		#$PlasticItem4.visible = false
		#if(GameData.plastic_caught >= 1):
			#$PlasticItem4.visible = false
			#$PlasticItem2.visible = false
			#$PlasticItem.visible = false
	#else:
		#$PlasticItem.visible = false
		#$PlasticItem2.visible = false
		#$PlasticItem4.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hook.position = HookPosition[currentPosition].position
	match currentState:
		Ministate.running:
			pass
		Ministate.stopped:
			mytimer.stop()
	$PlasticItem3.visible = false
	if(GameData.plastic_caught == 1):
		$PlasticItem4.visible = false
	if(GameData.plastic_caught == 2):
		$PlasticItem4.visible = false
		$PlasticItem2.visible = false

func _on_timer_timeout() -> void:
	currentPosition += 1
	if(currentPosition >= Positionamount):
		currentPosition = 0
	
	pass # Replace with function body.

func Fishfang() -> void:
	if(currentPosition in winposition):
		if(GameData.plastic_population >= 1):
			GameData.plastic_caught_func()
			GameData.total_plastic_caught_func()
			GameData.plastic_population_func()
			GameData.save_data()
			sound_positive.play()
			label.text = "Congratulation! You have caught " + str(GameData.total_plastic_caught) + " plastic(s). Auto close after catching " + str(GameData.max_plastic-GameData.plastic_caught) + " more plastics."
			time_system.log("plastic caught")
			if(GameData.plastic_caught >= GameData.max_plastic):
				if(GameData.current_day_str != time_system.get_time().split(" ")[0]):
					if GameData.current_day_int == 6:
						GameData.end_of_the_week()
					else:
						GameData.current_day_int = GameData.current_day_int + 1
						GameData.current_day_str = GameData.days_of_the_week[GameData.current_day_int]
						GameData.plastic_growth_func()
						GameData.fish_growth_func()
						GameData.fish_health_func()
						GameData.fish_price_func()
						GameData.save_data()
						time_system.log("exit boat navigation")
						time_system.log("day end")
						time_system.log("start scene")
						get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
					GameData.plastic_reset_func()
					GameData.save_data()
				else:
					GameData.plastic_reset_func()
					GameData.save_data()
					get_tree().change_scene_to_file("res://201. BoatNavigation/Scenes/BoatNavigation.tscn")
				
		else:
			sound_positive.play()
			label.text = "                           Nice! No more plastic left to catch.                           "
			time_system.log("no plastic left")
	else:
		GameData.plastic_failed_func()
		GameData.save_data()
		sound_negativ.play()
		label.text = "                Uh Oh! You have lost " + str(GameData.failed_plastic) + " times. Auto close after losing " + str(GameData.max_plastic_fail-GameData.failed_plastic) + " times."
		time_system.log("catching plastic failed")
		if(GameData.failed_plastic >= GameData.max_plastic_fail):
			if(GameData.current_day_str != time_system.get_time().split(" ")[0]):
				if GameData.current_day_int == 6:
					GameData.end_of_the_week()
				else:
					GameData.current_day_int = GameData.current_day_int + 1
					GameData.current_day_str = GameData.days_of_the_week[GameData.current_day_int]
					GameData.plastic_growth_func()
					GameData.fish_growth_func()
					GameData.fish_health_func()
					GameData.fish_price_func()
					GameData.save_data()
					time_system.log("exit boat navigation")
					time_system.log("day end")
					time_system.log("start scene")
					get_tree().change_scene_to_file("res://414. Day End/Scene/day_end.tscn")
				GameData.plastic_fail_reset_func()
				GameData.save_data()
			else:
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
