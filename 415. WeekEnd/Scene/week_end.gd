extends Control
@onready var plasticgoaltext: RichTextLabel =  $"Plastic Goal"

var Dialog_text = ["test"]
var fish_prob = ["After a long week of fishing, you will be judged based on the fish population and plastic quota", 
			"You stand before the uninterested policeman, who will judge your results",
			"'Lets see if I need to put you back behind the bars?' he says",
			"'You were able to hit your plastic quota!'. the policemen says: 'BUT',",
			"The fish population declined",
			"He shakes his head slowly and brings you behind bars",
			"You are jailed!",
			 ]
			
var plastic_prob = ["After a long week of fishing, you will be judged based on the fish population and plastic quota", 
			"You stand before the uninterested policeman, who will judge your results",
			"'Lets see if I need to put you back behind the bars?' he says",
			"'Fish population looks good'. the policemen says: 'BUT',",
			"You failed to hit your plastic quota",
			"He shakes his head slowly and brings you behind bars",
			"You are jailed!",
			 ]
			
var both_prob = ["After a long week of fishing, you will be judged based on the fish population and plastic quota", 
			"You stand before the uninterested policeman, who will judge your results",
			"'Lets see if I need to put you back behind the bars?' he says",
			"The fish population declined",
			"AND You failed to hit your plastic quota as well",
			"He shakes his head with anger and brings you behind bars",
			"You are jailed!",
			 ]

var no_prob = ["After a long week of fishing, you will be judged based on the fish population and plastic quota", 
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

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameData.check_plastic_amount() and GameData.check_fish_amount(): 
		time_system.log("met all criteria")
		Dialog_text = no_prob
	elif GameData.check_plastic_amount():
		time_system.log("fish criteria not met")
		Dialog_text = fish_prob
	elif GameData.check_fish_amount():
		time_system.log("plastic quota not met")
		Dialog_text = plastic_prob
	else:
		time_system.log("no criteria was met")
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
