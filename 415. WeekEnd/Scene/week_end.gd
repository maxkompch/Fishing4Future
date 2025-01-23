extends Control
@onready var plasticgoaltext: RichTextLabel =  $"Plastic Goal"

var Dialog_text = ["test"]
var fish_prob = ["After fishing, you'll be judged on the fish and plastic quota, and whether you supported your family.", 
			"You stand before the uninterested policeman, who will judge your results",
			"'Lets see if I need to put you back behind the bars?' he says",
			"'You were able to hit your plastic quota!'. the policemen says: 'BUT',",
			"The fish population declined",
			"He shakes his head slowly and brings you behind bars",
			"You've been thrown in jail!",
			 ]
			
var plastic_prob = ["After fishing, you'll be judged on the fish and plastic quota, and whether you supported your family.", 
			"You stand before the uninterested policeman, who will judge your results",
			"'Lets see if I need to put you back behind the bars?' he says",
			"'Fish population looks good'. the policemen says: 'BUT',",
			"You failed to hit your plastic quota",
			"He shakes his head slowly and brings you behind bars",
			"You've been thrown in jail!",
			 ]
			
var both_prob = ["After fishing, you'll be judged on the fish and plastic quota, and whether you supported your family.", 
			"You stand before the uninterested policeman, who will judge your results",
			"'Lets see if I need to put you back behind the bars?' he says",
			"The fish population declined",
			"AND You failed to hit your plastic quota as well",
			"He shakes his head with anger and brings you behind bars",
			"You've been thrown in jail!",
			 ]

var family_prob = ["After fishing, you'll be judged on the fish and plastic quota, and whether you supported your family.", 
			"You stand before the uninterested policeman, who will judge your results",
			"'Lets see if I need to put you back behind the bars?' he says",
			"'The fish population is okay, and plastic quota was met!', he says",
			"BUT you failed to support your family thrice!!",
			"'Your family has left you', he says",
			"He shakes his head with anger and brings you behind bars",
			"You've been thrown in jail!",
			 ]
			
var no_prob = ["After fishing, you'll be judged on the fish and plastic quota, and whether you supported your family.", 
			"You stand before the uninterested policeman, who will judge your results",
			"'Lets see if I need to put you back behind the bars?' he says",
			"'All looks fine! You are a free man now!', he says",
			"You happily return to your family.",
			 ]

var answer_finished = false
var game_over = false
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var red_strike = [$StrikeRed,$StrikeRed2,$StrikeRed3]
@onready var Text = $RichTextLabel

func add_family_crying(dialog_array: Array, family_text: String) -> void:
	var index = 4  # The target index is 4 ("The fish population declined")
	dialog_array.insert(index + 1, family_text)  # Insert the family text after index 4
	
# Called when the node enters the scene tree for the first time.
func _ready():
	time_system.is_paused=true
	if GameData.strike_counter >= 3:
		var family_crying_text = "AND you failed to support your family thrice!!"
		add_family_crying(both_prob, family_crying_text)
		add_family_crying(fish_prob, family_crying_text)
		add_family_crying(plastic_prob, family_crying_text)
		
	if GameData.check_plastic_amount() and GameData.check_fish_amount() and GameData.strike_counter < 3: 
		time_system.log("no problem")
		Dialog_text = no_prob
	elif GameData.check_plastic_amount() and GameData.check_fish_amount() and GameData.strike_counter >= 3:
		time_system.log("family problem")
		Dialog_text = family_prob
	elif GameData.check_plastic_amount() and not GameData.check_fish_amount() and GameData.strike_counter < 3:
		time_system.log("fish problem")
		Dialog_text = fish_prob
	elif GameData.check_plastic_amount() and not GameData.check_fish_amount() and GameData.strike_counter >= 3:
		time_system.log("fish and family problem")
		Dialog_text = fish_prob
	elif not GameData.check_plastic_amount() and GameData.check_fish_amount() and GameData.strike_counter < 3:
		time_system.log("plastic problem")
		Dialog_text = plastic_prob
	elif not GameData.check_plastic_amount() and GameData.check_fish_amount() and GameData.strike_counter >= 3:
		time_system.log("plastic and family problem")
		Dialog_text = plastic_prob
	elif not GameData.check_plastic_amount() and not GameData.check_fish_amount() and GameData.strike_counter < 3:
		time_system.log("fish and plastic problem")
		Dialog_text = both_prob
	else:
		time_system.log("no criteria met")
		Dialog_text = both_prob

		
	Anzahl_an_Dialog_text = Dialog_text.size()
	Text.text = Dialog_text[0]
	
	plasticgoaltext.text = "This Week Plastic caught: "+ str(GameData.total_plastic_caught) + "/" + str(GameData.plastic_target)
	
	for strike in red_strike.size():
		if strike < GameData.strike_counter:
			red_strike[strike].visible = true
		else:
			red_strike[strike].visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("action"):
		if DialogPlatz < Anzahl_an_Dialog_text - 1:
			DialogPlatz += 1
			Text.text = Dialog_text[DialogPlatz]  # Set the new dialog line
			wordCount = 0  # Reset word count for the next line
			answer_finished = false  # Wait for the next line to finish revealing
		else:
			# All dialog lines are shown, transition to game over screen
			_game_over()

func _game_over():
	GameData.resetDaycounter()
	GameData.current_time_str = "Sunday 23:59:00"
	GameData.save_data()
	time_system.log("trigerring game over")
	get_tree().change_scene_to_file("res://415. WeekEnd/Scene/game_over.tscn")
	
func _on_timer_timeout():
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
