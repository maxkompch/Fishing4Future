extends Control
@onready var plasticgoaltext: RichTextLabel =  $"Plastic Goal"
var Dialog_text = ["test"]
var begin_text = ["After a long week of fishing, you will be judged if you reached your quota on plastic", 
			"You stand before the unintrested policeman, who will judge your results",
			"'Lets see how much plastic you collected and if I need to put you back behind bars?' he says",
			 ]

var yes_dialog = ["'You collected enough'. the policemen says: 'you can walk around freely for another week'.",
			"You were able to hit your quota, but next week is already started"
			]

var no_dialog = ["He shakes his head slowly and brings you behind bars",
			"You are a free man no more",
			]
			
var strike_dialog = [ "You shake your head slowly.",
			"'I can't do this anymore' Tears dropping from your partners eyes",
			"'I have to give our children a better life' She started packing her and the childrens clothes",
			"'I'm sorry, this isn't your fault.'",
			"This evening you went to bed in an empty home.",
		]

var answer = yes_dialog
var answer_finished = false
var game_over = false
var Anzahl_an_Dialog_text
var DialogPlatz = 0
var wordCount = 0
@onready var red_strike = [$StrikeRed,$StrikeRed2,$StrikeRed3]
@onready var Text = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialog_text = begin_text
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
		wordCount = 0
		Text.visible_characters = wordCount
		DialogPlatz += 1
		if (DialogPlatz > Anzahl_an_Dialog_text-1):
			DialogPlatz = 0
			if answer_finished:
				GameData.resetDaycounter()
				GameData.next_day()
			elif game_over:
				get_tree().change_scene_to_file("res://415. WeekEnd/Scene/game_over.tscn")
			else:
				if GameData.check_plastic_amount(): ###check quota
					Dialog_text = yes_dialog  ### ennough plast
					Anzahl_an_Dialog_text = Dialog_text.size()
					Text.text = Dialog_text[0]
					answer_finished = true
				else: #no engough
					Dialog_text = no_dialog
					Anzahl_an_Dialog_text = Dialog_text.size()
					Text.text = Dialog_text[0]
					game_over = true
		Text.text = Dialog_text[DialogPlatz]
	pass

func _on_timer_timeout():
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
