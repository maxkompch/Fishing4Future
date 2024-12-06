extends Control

var Dialog_text = ["test"]
var begin_text = ["After a long day of fishing, you come home to your family", 
			"You put away your fishing gear and meet your partner in the kitchen",
			"'Do you have enough money for today?' she asked looking at you with hopeful eyes",
			 ]

var yes_dialog = ["'I was able to get it'. Your partner sighs a breath of relieve.",
			"You and your family didn't go hungry tonight"
			]

var no_dialog = ["You shake your head slowly and gave the last money you owned to your wife",
			"You and your family went hungry tonight",
			]
			
var strike_dialog = [ "You shake your head slowly.",
			"'I can't do this anymore' Tears dropping from your partners eyes",
			"'I have to give our children a better life' She started packing her and the childrens clothes",
			"'I'm sorry, this isn't your fault.'",
			"This evening you went to bed in an empty home.",
		]

var answer = yes_dialog
var answer_finished = false
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
				get_tree().change_scene_to_file("res://405. Start Area/scenes/start_area.tscn")
			else:
				if GameData.auto_deduction():
					Dialog_text = yes_dialog
				else: 
					if GameData.strike_counter < 3 and GameData.strike_counter > 0:
						Dialog_text = no_dialog
						print(GameData.strike_counter)
						red_strike[GameData.strike_counter].visible = true
					elif GameData.strike_counter < 4:
						Dialog_text = strike_dialog
						red_strike[GameData.strike_counter].visible = true
						
				Anzahl_an_Dialog_text = Dialog_text.size()
				Text.text = Dialog_text[0]
				answer_finished = true
		Text.text = Dialog_text[DialogPlatz]
	pass

func _on_timer_timeout():
	if(wordCount < 1000):
		wordCount += 1
		Text.visible_characters = wordCount
